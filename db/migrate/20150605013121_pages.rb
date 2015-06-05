class Pages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :user_id, :null => false, :default => 1
    	t.string :label, :null => false, :default => ""
    	t.string :permalink, :null => false, :default => ""
    	t.integer :position
    	t.integer :parent_id, :null => true
    	t.boolean :secure, :default => false
    	t.string :snippet, :null => false, :default => ""
      t.timestamps null: false
    end

    add_index :pages, :permalink  	
  end
end
