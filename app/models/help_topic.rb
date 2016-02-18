class HelpTopic < ActiveRecord::Base
	extend ActsAsTree::TreeWalker
	extend ActsAsTree::TreeView
	
	acts_as_tree order: 'position'
	acts_as_taggable_on :keywords

	ICON = "fa fa-fw fa-question-circle"

end