class Page < ActiveRecord::Base
	belongs_to :user

	acts_as_tree :order => "position"

	ICON = "fa fa-fw fa-file"
end