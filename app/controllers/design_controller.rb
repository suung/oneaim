class DesignController < ApplicationController
  before_filter :login_required
  
  def index
    @css = File.read(File.join(RAILS_ROOT, 'tmp', 'stylesheets', 'oneaim.css'))
   # render :text => @css, :content_type => 'text/css'
  end

  def save
    @css = params[:design][:css]
    File.open(File.join(RAILS_ROOT, 'tmp', 'stylesheets', 'oneaim.css'), 'w') do |css_file|
      css_file.write(@css)
    end
    flash[:notice] = "Design updated."
  end

end
