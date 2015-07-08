class UserSettings < ActiveRecord::Migration
  def change
		create_table :settings do |t|
			t.integer :user_id, :null => false, :default => 1
			t.integer :font_id, :null => false, :default => 0
			t.timestamps null: false
		end
  end
end
