class UserSettings < ActiveRecord::Migration
  def up
		create_table :settings do |t|
			t.integer :user_id, :null => false, :default => nil
			t.integer :font_id, :null => false, :default => 0
			t.integer :font_weight, :null => false, :default => 400
			t.boolean :fluid, :null => false, :default => true
			t.boolean :top_nav, :null => false, :default => false
			t.timestamps null: false
		end
  end

  def down
  	drop_table :settings
  end
end
