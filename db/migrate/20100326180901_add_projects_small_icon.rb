class AddProjectsSmallIcon < ActiveRecord::Migration
  def self.up
    add_column :projects, :small_icon, :string
  end

  def self.down
    remove_column :projects, :small_icon
  end
end
