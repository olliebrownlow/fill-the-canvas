class Paint
  attr_reader :column, :row, :colour, :canvas

  def initialize(column, row, colour, canvas)
    @column = column
    @row = row
    @colour = colour
    @canvas = canvas
  end

  def colour_pixel
    canvas[row - 1][column - 1] = colour
    canvas
  end
end
