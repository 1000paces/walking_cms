class Row < ActiveRecord::Base
	belongs_to :page
	has_many :cells, -> { order("position ASC")}

	ICON_SHORT = "fa-pause fa-rotate-90"
	ICON = "fa fa-fw #{ICON_SHORT}"

	def overall_width
		width = 0
		self.cells.each do |c|
			width = width + c.width + c.offset
		end
		return width
	end

	def duplicate(pageId)
		new_row = self.dup
		new_row.page_id = pageId
		new_row.save

		self.cells.each do |c|
			c.duplicate(new_row.id)
		end
	end

end