class Page < ActiveRecord::Base
  acts_as_list
  named_scope :with_link, :conditions => ["nav_link IS NOT NULL"]
  named_scope :by_position, :order => ["position ASC"]
  
  before_create :require_position
  
  
  # FIXME refactor to SQL MAX
  def require_position
    highest_page = Page.find(:first, :select => [:id], :order => [:position]).max
    position = highest_page ? highest_page.position + 1 : 1
  end

  def lowest?
    lower_item.nil? ? true : false
  end
  
  def highest?
    higher_item.nil? ? true : false
  end
  
  
end
