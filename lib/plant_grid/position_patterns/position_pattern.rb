class PositionPattern
  def initialize(grid, width, height, plant)
    @grid = grid
    @width = width
    @height = height
    @plant = plant
  end

  def position
    raise RuntimeError
  end
end