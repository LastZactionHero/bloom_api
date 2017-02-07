class PlantGridCell < GridCell
  def initialize(width_percent, height_percent, plant, position_pattern_klass, options = {})
    super(width_percent, height_percent, options)

    @plant = plant
    @position_pattern_klass = position_pattern_klass
  end

  def draw
    grid = (1..@height).map{ Array.new(@width, ' ') }
    grid.each_with_index do |row, y_idx|
      row.each_with_index do |cell, x_idx|
        grid[y_idx][x_idx] = '|' if x_idx == 0
        grid[y_idx][x_idx] = '-' if y_idx == 0
      end
    end
    position_pattern = @position_pattern_klass.new(grid, @width, @height, @plant)
    position_pattern.position

    grid
  end
end