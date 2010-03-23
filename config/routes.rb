ActionController::Routing::Routes.draw do |map|

    
  map.logout '/one/logout', :controller => "user_sessions", :action => "destroy"
  
  map.design "/one/design", :controller => "design"
  map.save_design "/one/design/save", :controller => "design", :action => "save"
  

  
  map.show_page '/display/:id', :controller => 'application', :action => 'display'
  
  map.with_options :controller => 'application' do |m|
    m.css_route "/stylesheets/oneaim.css", :action => 'load_css'
    m.about '/about', :action => 'about'
    m.contact '/contact', :action => 'contact'
    m.list_projects '/list_projects/:state', :action => 'projects', :state => 'open'
    m.show_project '/project/:id', :action => 'project'
  end
  
  map.one_admin '/one/aim', :controller => 'admin'
  
  map.resources :user_sessions
  
  map.resources :projects
 
  map.with_options :controller => 'pages' do |m|
    m.move_page_up "/pages/up/:id", :action => "up"
    m.move_page_down "/pages/down/:id", :action => "down"
  end
  map.resources :pages

  map.resources :users

  map.connect "/", :controller => 'application', :action => 'index'
end
