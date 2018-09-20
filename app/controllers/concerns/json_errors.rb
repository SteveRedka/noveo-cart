module JSONErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError,                      with: :render_500
    rescue_from ActiveRecord::RecordNotFound,       with: :render_404
    rescue_from ActionController::ParameterMissing, with: :render_400


    def render_400(errors = 'invalid_param_error', message: 'Invalid data parameters')
      render_errors(errors, 400)
    end

    def render_404(errors = 'invalid_request_error', message = 'Unable to resolve the request')
      render_errors(errors, 404)
    end

    def render_500(errors = 'internal_server_error', message = 'Internal server error')
      render_errors(errors, 500)
    end

    def render_errors(errors, status = 400)
      data = {
        error: {

        },
        status: 'failed',
        errors: Array.wrap(errors)
      }

      render json: data , status: status
    end


    def render_object_errors(obj, status = 400)
      if obj.is_a?(ActiveRecord::Base) # ActiveModel::Model for Mongoid
        render_object_errors(obj.errors, status)
      elsif obj.is_a?(ActiveModel::Errors)
        render_errors(obj.full_messages, status)
      else
        render_errors(obj, status)
      end
    end

  end
end
