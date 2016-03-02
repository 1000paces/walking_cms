class Pages < ActiveRecord::Migration
	def change
		create_table :pages do |t|
			t.integer :user_id, :null => false, :default => 1
			t.string :label, :null => false, :default => ""
			t.string :title, :null => false, :default => ""
			t.string :permalink, :null => false, :default => ""
			t.string :status, :null => false, :default => "DRAFT"
			t.boolean :fluid, :null => false, :default => true
			t.boolean :secure, :default => false
			t.string :snippet, :null => false, :default => ""
			t.string :password, :null => true
			t.integer :position
			t.integer :parent_id, :null => true, :index => true
			t.integer :children_count, :null => false, :default => 0
			t.timestamps null: false
		end

		add_index :pages, :permalink
    add_index :pages, [:permalink, :user_id], unique: true
	end
end
