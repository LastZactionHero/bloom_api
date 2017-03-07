module PlantGrid
  class PositionPattern
    def initialize(grid, width, height, plant, options = {})
      @grid = grid
      @width = width
      @height = height
      @plant = plant
      @options = options || {}
    end

    def position
      raise RuntimeError
    end
  end
end
