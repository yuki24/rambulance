# frozen_string_literal: true

module Rambulance
  ERROR_HTTP_STATUSES = Rack::Utils::SYMBOL_TO_STATUS_CODE.select do |status_in_words, http_status|
    # Exclude http statuses that:
    #   * represent a successful status(2xx, 3xx)
    #   * are unassigned(427, 430, 509)
    #   * is a joke definition(418)
    http_status >= 400 && ![418, 427, 430, 509].include?(http_status)
  end.invert

  class ExceptionsApp < ActionController::Base
    layout :layout_name

    begin
      skip_forgery_protection
    rescue
      # ignore errors from #skip_forgery_protection since older Rails adds this method later.
    end

    def self.call(env)
      exception       = env["action_dispatch.exception"]
      status_in_words = if exception
        ActionDispatch::ExceptionWrapper.rescue_responses[exception.class.to_s]
      else
        env["PATH_INFO"][1..-1].to_sym.tap do |_status_in_words|
          env["PATH_INFO"] = "/#{Rack::Utils::SYMBOL_TO_STATUS_CODE[_status_in_words]}"
        end
      end

      action(status_in_words).call(env)
    end

    def self.local_prefixes
      [Rambulance.view_path]
    end

    ERROR_HTTP_STATUSES.values.each do |status_in_words|
      eval <<-ACTION, nil, __FILE__, __LINE__ + 1
        def #{status_in_words}
          render(template_exists?(error_path) ? error_path : error_path(:internal_server_error))
        end
      ACTION
    end

    def process(action, *args)
      if action.to_s.empty?
        action = request.env["PATH_INFO"][1..-1].to_sym
        request.env["PATH_INFO"] = "/#{Rack::Utils::SYMBOL_TO_STATUS_CODE[action]}"
      end

      super
    end

    private

    def process_action(*)
      begin
        request.GET
      rescue ActionController::BadRequest
        request.env["MALFORMED_QUERY_STRING"], request.env["QUERY_STRING"] = request.env["QUERY_STRING"], ""
      rescue Mime::Type::InvalidMimeType
        request.env["MALFORMED_CONTENT_TYPE"], request.env["CONTENT_TYPE"] = request.env["CONTENT_TYPE"], "text/plain"
      end

      begin
        request.POST
      rescue ActionController::BadRequest
        request.env["MALFORMED_BODY"], request.env["rack.input"] = request.env["rack.input"], StringIO.new
      rescue Mime::Type::InvalidMimeType
        request.env["MALFORMED_CONTENT_TYPE"], request.env["CONTENT_TYPE"] = request.env["CONTENT_TYPE"], "text/plain"
      end

      begin
        request.accepts
      rescue Mime::Type::InvalidMimeType
        request.env["MALFORMED_HTTP_ACCEPT"], request.env["HTTP_ACCEPT"] = request.env["HTTP_ACCEPT"], "*/*"
      end

      # The #formats method needs to be called after the sanitization above.
      request.formats << Mime::Type.lookup('text/plain')

      super
    end

    def send_action(name, *args)
      @_status          = request.env["PATH_INFO"][1..-1].to_i
      @_response.status = @_status
      @_body            = { :status => @_status, :error => Rack::Utils::HTTP_STATUS_CODES.fetch(@_status.to_i, Rack::Utils::HTTP_STATUS_CODES[500]) }

      super
    end

    def status_in_words
      ERROR_HTTP_STATUSES[status.to_i]
    end

    def exception
      request.env["action_dispatch.exception"]
    end

    def error_path(status_in_words = status_in_words())
      "#{controller_path}/#{status_in_words}"
    end

    def layout_name
      request.format.json? ? false : Rambulance.layout_name
    end

    def controller_path
      Rambulance.view_path
    end

    helper_method :status_in_words, :exception
  end
end
