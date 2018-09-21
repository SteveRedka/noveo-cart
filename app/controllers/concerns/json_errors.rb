# This module adds functionality to return nice-looking error jsons
module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400

    def render_400(type = 'invalid_param_error',
                   params: nil,
                   message: 'Invalid data parameters')
      render_errors(type: type, params: params, message: message, status: 400)
    end

    def render_404(type = 'invalid_request_error',
                   message = 'Unable to resolve the request')
      render_errors(type: type, message: message, status: 404)
    end

    def render_500(type = 'internal_server_error',
                   message = 'Internal server error')
      render_errors(type: type, message: message, status: 500)
    end

    def render_errors(type: 'internal_server_error',
                      message: 'Internal server error',
                      params: nil,
                      status: 500)
      result = { 'error':
                 { 'type': type,
                   'message': message
                 }
               }
      result['params'] = params if params
      render json: result, status: status
    end
  end
end
