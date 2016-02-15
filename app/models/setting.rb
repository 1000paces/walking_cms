class Setting < ActiveRecord::Base
	belongs_to :user
	belongs_to :font

	NAV_LOCATION = {
		"Fixed to Top" => 0,
		"Below Header Image - Rounded" => 1,
		"Below Header Image - Square" => 2,
		"Fixed to Bottom" => 3,
		"Left Column" => 4,
		"Right Column" => 5
	}

	NAV_COLOR = {
		"Light" => 0,
		"Dark" => 1,
		"Primary" => 2,
		"Secondary" => 3
	}
end