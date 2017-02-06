class Printer
  def initialize(grid)
    @grid = grid
  end

  def draw
      coords = []

      grid_values = @grid.draw
      grid_values.each_with_index do |row, y_pos|
        row.each_with_index do |cell, x_pos|
          coords << {x_pos: x_pos, y_pos: y_pos, plant: cell} if cell.is_a?(PlantTemplate)
        end
      end; 0
      coords
  end
end