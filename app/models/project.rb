class Project < ActiveRecord::Base
  named_scope :open_ones, :conditions => { :is_open => true }
  named_scope :finished_ones, :conditions => { :is_open => false }
  
  def url
    (url = read_attribute(:url)) =~ /^http/ ? url : "http://#{url}"
  end
end
