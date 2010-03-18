class UserSessionsController < ApplicationController


  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to one_admin_url
    else
      render :update do |page|
        page.replace_html "admin_navigation_tabnav_content", render(:action => :new)
      end
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to :controller => "application"
  end
  
end
