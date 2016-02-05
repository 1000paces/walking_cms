class AddImageShape < ActiveRecord::Migration
  def change
  	add_column :cells, :shape, :string, :default => "rounded"
  end
end
