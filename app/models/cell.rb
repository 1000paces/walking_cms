class Cell < ActiveRecord::Base
	belongs_to :row

	def division
		case self.width
		when 12
			return [6,6]
		when 11
			return [5,6]
		when 10
			return [5,5]
		when 9
			return [4,5]
		when 8
			return [4,4]
		when 7
			return [3,4]
		when 6
			return [3,3]
		when 5
			return [2,3]
		when 4
			return [2,2]
		when 3
			return [1,2]
		when 2
			return [1,2]
		when 1
			return [1,1]
		else
			return [6,6]
		end
	end
end