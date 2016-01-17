module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ApplicationController::Forbidden, with: :rescue403
    rescue_from ApplicationController::IpAddressRejected, with: :rescue403
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private
  def rescue403(exception = nil)
    @exception = exception
    logger.info "Rendering 403 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_403', status: 403, content_type: 'text/html'
  end

  def rescue404(exception = nil)
    @exception = exception
    logger.info "Rendering 404 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_404', status: 404, content_type: 'text/html'
  end

  def rescue500(exception = nil)
    @exception = exception
    logger.info "Rendering 500 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_500', status: 500, content_type: 'text/html'
  end
end
