class Project < ActiveRecord::Base
  named_scope :open_ones, :conditions => ["is_open = ?",true]
  named_scope :finished_ones, :conditions => ["is_open != ?",true]
end
