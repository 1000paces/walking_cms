class Row < ActiveRecord::Base
	belongs_to :page
	has_many :cells, -> { order("position ASC")}

	def overall_width
		width = 0
		self.cells.each do |c|
			width = width + c.width + c.offset
		end
		return width
	end

end