class ExceptionsApp < Rambulance::ExceptionsApp
  def not_found; end

  def internal_server_error
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
