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

    BAD_REQUEST_EXCEPTION = begin
                              ActionController::BadRequest
                            rescue NameError
                              TypeError # Rails 3.2 doesn't know about ActionController::BadRequest
                            end

    def self.call(env)
      exception       = env["action_dispatch.exception"]
      status_in_words = if exception
        ActionDispatch::ExceptionWrapper.rescue_responses[exception.class.to_s]
      else
        env["PATH_INFO"][1..-1].to_sym.tap do |status_in_words|
          env["PATH_INFO"] = "/#{Rack::Utils::SYMBOL_TO_STATUS_CODE[status_in_words]}"
        end
      end

      action(status_in_words).call(env)
    end

    def self.local_prefixes
      [Rambulance.view_path]
    end if ActionPack::VERSION::STRING >= "4.2.0"

    ERROR_HTTP_STATUSES.values.each do |status_in_words|
      eval <<-ACTION
        def #{status_in_words}
          render(template_exists?(error_path) ? error_path : error_path(:internal_server_error))
        end
      ACTION
    end

    private

    def process_action(*)
      begin
        request.GET
      rescue BAD_REQUEST_EXCEPTION
        env["MALFORMED_QUERY_STRING"], env["QUERY_STRING"] = env["QUERY_STRING"], ""
      end

      super
    end

    def send_action(name, *args)
      @_status          = env["PATH_INFO"][1..-1].to_i
      @_response.status = @_status
      @_body            = { :status => @_status, :error => Rack::Utils::HTTP_STATUS_CODES.fetch(@_status.to_i, Rack::Utils::HTTP_STATUS_CODES[500]) }

      super
    end

    def status_in_words
      ERROR_HTTP_STATUSES[status.to_i]
    end

    def exception
      env["action_dispatch.exception"]
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
