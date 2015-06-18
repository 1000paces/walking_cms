class Rows < ActiveRecord::Migration
  def change
		create_table :rows do |t|
			t.integer :cell_count, :null => false, :default => 1
			t.integer :position, :null => false, :default => 0
			t.integer :page_id, :null => false, :index => true
			t.timestamps null: false
		end
  end
end
