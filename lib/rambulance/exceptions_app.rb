module Rambulance
  ERROR_HTTP_STATUSES = Rack::Utils::SYMBOL_TO_STATUS_CODE.select do |status_in_words, http_status|
    # Exclude http statuses that:
    #   * represent a successful status(2xx, 3xx)
    #   * are unassigned(427, 430, 509)
    #   * is a joke definition(418)
    http_status >= 400 && ![418, 427, 430, 509].include?(http_status)
  end.invert

  class ExceptionsApp < ActionController::Base
    def self.call(env)
      exception       = env["action_dispatch.exception"]
      status_in_words = ActionDispatch::ExceptionWrapper.rescue_responses[exception.to_s]

      action(status_in_words).call(env)
    end

    ERROR_HTTP_STATUSES.values.each do |status_in_words|
      eval <<-ACTION
        def #{status_in_words}
          render(template: template_path, layout: Rambulance.layout_name)
        end
      ACTION
    end

    private

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

    def template_path
      "#{Rambulance.view_path}/#{status_in_words}"
    end
  end
end
