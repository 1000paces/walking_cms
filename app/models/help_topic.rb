class HelpTopic < ActiveRecord::Base

	acts_as_taggable_on :keywords

	ICON = "fa fa-fw fa-question-circle"


end