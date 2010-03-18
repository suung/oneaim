# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :logged_in?

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout lambda { |c| c.request.xhr? ? false : 'oneaim'}
  
  rescue_from PermissionDenied, :with => :render_permission_denied
  
  
  def index
    render :template => 'common/index'
  end
  
  def display
    @page = Page.find(params[:id])
    respond_to do |format|
      format.js { render :template => 'common/display'}
    end
  end
  
  
  def about
    respond_to do |format|
      format.js { render :template => 'common/about'}
    end
  end
  
  def contact
    respond_to do |format|
      format.js { render :template => 'common/contact'}
    end
  end
  
  def projects
    if params[:state] == 'open'
      @projects = Project.open_ones
    elsif params[:state] == 'finished'
      @projects = Project.finished_ones
    end
    respond_to do |format|
      format.js { render :template => "common/projects" }
    end
  end
  
  def project
    @project = Project.find(params[:id])
    if request.xhr?
      render :template => "projects/show", :layout => false 
    end
  end

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  
  def login_required
    raise PermissionDenied unless logged_in?
  end
  
  def logged_in?
    current_user ? true : false
  end
  
  def render_permission_denied
    redirect_to new_user_session_url
  end
end
