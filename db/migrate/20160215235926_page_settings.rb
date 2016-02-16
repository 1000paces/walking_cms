class PageSettings < ActiveRecord::Migration
  def change
		add_index :settings, [:user_id, :page_id], :unique => true
		add_index :settings, :user_id, :unique => true
		add_index :settings, :page_id, :unique => true
  end
end
