class HelpTopicPosition < ActiveRecord::Migration
  def change
		add_column :help_topics, :position, :integer, :null => false, :index => true, :default => 0
		add_column :help_topics, :icon, :string, :default => 'HelpTopic::ICON'

		execute("REPLACE INTO help_topics(id, title, parent_id, position, permalink, created_at, updated_at, icon) VALUES
			(1, 'Pages', NULL, 0, 'pages', NOW(), NOW(), 'Page::ICON'),
			(2, 'Rows', 1, 0, 'rows', NOW(), NOW(), 'Row::ICON'),
			(3, 'Cells', 2, 0, 'cells', NOW(), NOW(), 'Cell::ICON'),
			(4, 'Text', 3, 0, 'text', NOW(), NOW(), 'Cell::TEXT_ICON'),
			(5, 'Images', 3, 1, 'images', NOW(), NOW(), 'Cell::IMAGE_ICON'),
			(6, 'Code', 3, 2, 'code', NOW(), NOW(), 'Cell::CODE_ICON'),
			(7, 'Cell Settings', 3, 3, 'cell_settings', NOW(), NOW(), 'Cell::SETTINGS_ICON'),
			(8, 'Organize Cells', 1, 1, 'organize', NOW(), NOW(), 'Page::SORT'),
			(9, 'Navigation', 1, 2, 'navigation', NOW(), NOW(), 'Page::MENU'),
			(10, 'Header', 1, 3, 'header', NOW(), NOW(), 'Cell::IMAGE_ICON'),
			(11, 'Account Settings', NULL, 1, 'account_settings', NOW(), NOW(), 'Setting::ICON'),
			(12, 'Account', NULL, 2, 'account', NOW(), NOW(), 'User::ICON'),
			(13, 'Domain', NULL, 3, 'domain', NOW(), NOW(), 'Domain::ICON')
			");
  end
end
