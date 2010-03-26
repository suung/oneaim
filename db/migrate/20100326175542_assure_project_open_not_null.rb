class AssureProjectOpenNotNull < ActiveRecord::Migration
  def self.up
    change_column :projects, :is_open, :boolean, :default => false, :null => false
  end

  def self.down
  end
end
