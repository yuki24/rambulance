class ExceptionsApp < Rambulance::ExceptionsApp
  def not_found; end

  def internal_server_error
    render_custom_error_page
  end

  def not_acceptable
    render_custom_error_page
  end

  private
    def render_custom_error_page
      render inline: <<-BODY
        <html>
          <body>
            <h1>Custom error page</h1>
            <p>Something went wrong!</p>
          </body>
        </html>
      BODY
    end
end
