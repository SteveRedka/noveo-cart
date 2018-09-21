class ErrorsController < ActionController::Base
  include JSONErrors

  def not_found
    render_errors(type: 'invalid_request_error',
                 message: "Unable to resolve the request '#{request.env['PATH_INFO']}'.",
                 status: 404)
  end
end
