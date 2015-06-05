class Page < ActiveRecord::Base
	belongs_to :user

	acts_as_tree :order => "position"
end