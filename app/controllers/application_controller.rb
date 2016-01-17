class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  class Forbidden < ActionController::ActionControllerError; end
  class IpAddressRejected < ActionController::ActionControllerError; end

  rescue_from Exception, with: :rescue500

  rescue_from Forbidden, with: :rescue403
  rescue_from IpAddressRejected, with: :rescue403
  rescue_from ActionController::RoutingError, with: :rescue404
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404

  layout :set_layout

  private
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

  def rescue403(exception = nil)
    @exception = exception
    logger.info "Rendering 403 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_403', status: 403, layout: 'customer', content_type: 'text/html'
  end

  def rescue404(exception = nil)
    @exception = exception
    logger.info "Rendering 404 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_404', status: 404, layout: 'customer', content_type: 'text/html'
  end

  def rescue500(exception = nil)
    @exception = exception
    logger.info "Rendering 500 with exception: #{@exception.message}" if @exception
    render template: 'errors/error_500', status: 500, layout: 'customer', content_type: 'text/html'
  end
end
