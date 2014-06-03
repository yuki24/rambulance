module Rambulance
  class ExceptionsApp < ActionController::Base
    def self.call(env)
      exception = env["action_dispatch.exception"]
      status_in_words = ActionDispatch::ExceptionWrapper.rescue_responses[exception.to_s]
      action(status_in_words).call(env)
    end

    Rack::Utils::SYMBOL_TO_STATUS_CODE.keys.each do |status_in_words|
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
      Rack::Utils::SYMBOL_TO_STATUS_CODE.invert[status.to_i]
    end

    def exception
      env["action_dispatch.exception"]
    end

    def template_path
      "#{Rambulance.view_path}/#{status_in_words}"
    end
  end
end
