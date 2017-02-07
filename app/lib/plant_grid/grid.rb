class Grid
  def initialize(cell, width, height)
    @cell = cell
    @width = width
    @height = height

    init_cell_dimensions
  end

  def draw
    grid = @cell.draw
    grid.each_with_index do |row, y_idx|
      row.each_with_index do |cell, x_idx|
        grid[y_idx][x_idx] = '|' if x_idx == 0 || x_idx == row.length - 1
        grid[y_idx][x_idx] = '-' if y_idx == 0 || y_idx == grid.length - 1
      end
    end
    grid
  end

  private

  def init_cell_dimensions
    @cell.set_dimensions(@width, @height)
  end
end