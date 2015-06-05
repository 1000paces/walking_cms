class CreateDomains < ActiveRecord::Migration
  def change
    create_table :domains do |t|
      t.integer :user_id, :null => false, :default => 1
    	t.string :name, :null => false, :default => ""
    	t.string :label, :null => false, :default => ""
    	t.string :regex, :null => false, :default => ""
    	t.integer :position
    	t.integer :image_id
    	t.boolean :secure, :default => false
    	t.string :snippet, :null => false, :default => ""
      t.timestamps null: false
    end

    add_index :domains, :name
  end
end
