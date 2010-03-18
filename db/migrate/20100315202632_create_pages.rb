class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :nav_link
      t.text :body
      t.string :icon

      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
