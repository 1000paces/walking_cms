class FrameworkSetting < ActiveRecord::Migration
  def change
  	add_column :settings, :framework, :string, :default => "b4"
  end
end
