class UserSessionsController < ApplicationController


  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      render :update do |page|
        page << "document.location = '#{one_admin_url}'"
      end
    else
      flash[:errors] = "Wrong login"
      render :update do |page|
        page << "Modalbox.hide();"
        page.replace_html "loginerrors", flash[:errors]
        page.show 'loginerrors'
      end
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to :controller => "application"
  end
  
end
