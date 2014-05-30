module Rambulance
  class ExceptionsApp < ActionController::Base
    def self.call(env)
      action(:render_error).call(env)
    end

    def render_error
      @_status          = env["PATH_INFO"][1..-1].to_i
      @_response.status = @_status
      @_body            = { :status => @_status, :error => Rack::Utils::HTTP_STATUS_CODES.fetch(@_status.to_i, Rack::Utils::HTTP_STATUS_CODES[500]) }

      public_send(status_in_words) if respond_to?(status_in_words)

      if response_body.blank?
        render(template: template_path, layout: Rambulance.layout_name)
      end
    end

    private

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
