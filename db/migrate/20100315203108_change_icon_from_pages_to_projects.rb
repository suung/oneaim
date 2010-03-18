class ChangeIconFromPagesToProjects < ActiveRecord::Migration
  def self.up
    remove_column :pages, :icon
    add_column :projects, :icon, :string
  end

  def self.down
    remove_column :projects, :icon
    add_column :pages, :icon, :string
  end
end
