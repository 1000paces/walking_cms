class Cells < ActiveRecord::Migration
  def change
		create_table :cells do |t|
			t.integer :width, :null => false, :default => 12
			t.integer :offset, :null => false, :default => 0
			t.integer :row_id, :null => false, :index => true
			t.text :body
			t.timestamps null: false
		end  	
  end
end
