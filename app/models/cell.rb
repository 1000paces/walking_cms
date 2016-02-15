class Cell < ActiveRecord::Base
	#attr_accessible :image, :remote_image_url
	belongs_to :row
	mount_uploader :image, ImageUploader

	after_find :fix_the_width
	
	BREAKPOINTS = {
		"Extra Small Devices (<544px)" => "xs",
		"Small Devices (≥544px)" => "sm",
		"Medium Devices (≥768px)" => "md",
		"Large Devices (≥992px)" => "lg",
		"Extra Large Devices (≥1200px)" => "xl"
	}

	WIDTH = {
		"Width 1 (1/12)" => 1,
		"Width 2 (1/6)" => 2,
		"Width 3 (Quarter Width)" => 3,
		"Width 4 (One Third Width)" => 4,
		"Width 5 (5/12)" => 5,
		"Width 6 (Half Width)" => 6,
		"Width 7 (7/12)" => 7,
		"Width 8 (2/3)" => 8,
		"Width 9 (Three Quarters)" => 9,
		"Width 10 (5/6)" => 10,
		"Width 11 (11/12)" => 11,
		"Width 12 (Full Width)" => 12,
	}

	OFFSET = {
		"No Offset" => 0,
		"Offset 1 (1/12)" => 1,
		"Offset 2 (1/6)" => 2,
		"Offset 3 (Quarter Width)" => 3,
		"Offset 4 (One Third Width)" => 4,
		"Offset 5 (5/12)" => 5,
		"Offset 6 (Half Width)" => 6,
		"Offset 7 (7/12)" => 7,
		"Offset 8 (2/3)" => 8,
		"Offset 9 (Three Quarters)" => 9,
		"Offset 10 (5/6)" => 10,
		"Offset 11 (11/12)" => 11,		
	}

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

	def empty?
		if self.body.blank? && self.image.blank? && self.embed_code.blank? && self.headline.blank?
			return true
		else
			return false
		end
	end

	private

	def fix_the_width
		if self.width > 12
			self.width = 12
		elsif width < 1
			self.width = 1
		end
	end
end