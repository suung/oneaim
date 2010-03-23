class AdminController < ApplicationController


  before_filter :login_required, :except => :index
  
  layout 'admin'

  def index
  end

  def signup
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        @user_session = UserSession.create(@user)
        redirect_to root_url
      end
    else
      @user = User.new
    end
  end
end
