class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.string :url
      t.boolean :is_open

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
