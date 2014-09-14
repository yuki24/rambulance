Rambulance.setup do |config|

  # List of pairs of exception/corresponding http status. In Rails, the default
  # mappings are below:
  #
  #   "ActionController::RoutingError"             => :not_found,
  #   "AbstractController::ActionNotFound"         => :not_found,
  #   "ActionController::MethodNotAllowed"         => :method_not_allowed,
  #   "ActionController::UnknownHttpMethod"        => :method_not_allowed,
  #   "ActionController::NotImplemented"           => :not_implemented,
  #   "ActionController::UnknownFormat"            => :not_acceptable,
  #   "ActionController::InvalidAuthenticityToken" => :unprocessable_entity,
  #   "ActionDispatch::ParamsParser::ParseError"   => :bad_request,
  #   "ActionController::BadRequest"               => :bad_request,
  #   "ActionController::ParameterMissing"         => :bad_request,
  #   "ActiveRecord::RecordNotFound"               => :not_found,
  #   "ActiveRecord::StaleObjectError"             => :conflict,
  #   "ActiveRecord::RecordInvalid"                => :unprocessable_entity,
  #   "ActiveRecord::RecordNotSaved"               => :unprocessable_entity
  #
  # If you add exceptions in this config, Rambulance uses the pairs you defined
  # here *in addition* to the default maddings. You can also override the default
  # mappings although you don't have to in most cases.
  # If Rambulance receives an exception that is not listed here, it'll render
  # the internal server error template and return 500 as http status.
  config.rescue_responses = {
    # "ActiveRecord::RecordNotUnique" => :unprocessable_entity,
    # "CanCan::AccessDenied"          => :forbidden,
    # "Pundit::NotAuthorizedError"    => :forbidden,
    # "YourCustomException"           => :not_found
  }

  # The template name for the layout of the error pages. The default value is
  # 'application'. For exmaple, if this value is set to "error_page", Rambulance uses
  # 'app/views/layout/error_page.html.erb' as a layout for all the error pages.
  config.layout_name = "application"

  # The directry name to organize error page templates. The default value is
  # 'errors'. For exmaple, if this value is set to "error_pages", Rambulance
  # uses e.g. 'app/views/error_pages/not_found.html.erb'.
  config.view_path = "errors"

end
