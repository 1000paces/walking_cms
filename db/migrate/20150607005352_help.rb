class Help < ActiveRecord::Migration
	def change
		create_table :help_topics do |t|
			t.string :title, :null => false, :default => ""
			t.text :body
			t.string :permalink, :null => false, :default => ""
			t.integer :parent_id, :null => true, :index => true
			t.timestamps null: false
		end

		add_index :help_topics, :permalink  	
  end
end
