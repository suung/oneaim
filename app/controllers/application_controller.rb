# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  helper_method :current_user_session, :current_user, :logged_in?, :current_page

  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  layout lambda { |c| c.request.xhr? ? false : 'oneaim'}
  
  rescue_from PermissionDenied, :with => :render_permission_denied
  
  
  def index
    @page = Page.with_link.first
    set_current_page @page
    render :template => '/common/index'
  end
  
  def display
    @page = Page.find(params[:id])
    set_current_page @page
    render :update do |page|
      page.replace_html "nav_one", render(:partial => "widgets/first_navigation_partial")
      page.replace_html "first_navigation_tabnav_content", "#{@page.title}<br/><br/>#{@page.body}"
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
    
    render :update do |page|
      page.replace_html "nav_two", render(:partial => 'widgets/second_navigation_partial')
    end
    
  end
  
  def project
    @project = Project.find(params[:id])
    if request.xhr?
      render :template => "projects/show", :layout => false 
    end
  end

  
  def load_css
    
    path = File.join Rails.root, 'tmp', 'stylesheets', 'oneaim.css'
    default_path = File.join Rails.root, 'public', 'stylesheets', 'oneaim-default.css'
    @css = File.read(File.exist?(path) ? path : default_path)
    render :text => @css, :content_type => "text/css"
  end
  
  private

  def current_page
    @current_page ||= session[:current_page]
  end
  
  def set_current_page page
    session[:page] = page.id
    @current_page = session[:page]
  end
  
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
