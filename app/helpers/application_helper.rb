module ApplicationHelper
  DIALOG_LINK_JS = "Modalbox.show(%s, { title: %s, width: 600, transitions: false, height: (window.innerHeight - 30) });return false;"
  
  def link_to_dialog(*args, &block)
    name = (block_given? ? capture(&block) : args.shift)
    url = args.shift
    html_options = (args.shift || {})
    icon = html_options[:icon] ? icon_tag(html_options.delete(:icon), 32) : ''
    link_to(name, url, { :onclick => DIALOG_LINK_JS%['this.href', "'#{icon}&nbsp;'+this.title"], :title => name }.merge(html_options))
  end

  
  
  
  
  #
  # ADMIN
  #
  # TODO refactor for non - js - mode
  

  def show_link item
    link_to_remote 'Show', :url => url_for(item), :update => "admin_navigation_tabnav_content", :method => :get 
  end
  
  def index_link arg
    link_to_remote 'List', :url => method(:"#{arg.to_s}_url").call, :update => "admin_navigation_tabnav_content", :method => :get
  end
  
  def edit_link item
    link_to_remote 'Edit', :url => method(:"edit_#{item.class.name.downcase}_url").call(item), :update => "admin_navigation_tabnav_content", :method => :get
  end
  
def destroy_link arg
  delete_link arg
end
  
def delete_link item
  link_to_remote 'Destroy', :url => url_for(item), :confirm => 'Are you sure?', :update => "admin_navigation_tabnav_content", :method => :delete 
end
   

def new_link arg
  link_to_remote 'New', :url => method(:"new_#{arg.to_s}_url").call, :update => "admin_navigation_tabnav_content", :method => :get 
end



end
