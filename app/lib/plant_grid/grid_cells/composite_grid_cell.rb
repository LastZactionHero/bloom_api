module PlantGrid
  class CompositeGridCell < GridCell
    def initialize(width_percent, height_percent, direction, cells, options = {})
      super(width_percent, height_percent, options)

      @direction = direction
      @cells = cells
    end

    def draw
      grid = []
      case @direction
      when :vertical
        @cells.each do |cell|
          grid += cell.draw
        end
      when :horizontal
        @cells.each do |cell|
          grid += cell.draw.transpose
        end
        grid = grid.transpose
      else
        raise ArgumentError
      end

      grid
    end

    def set_dimensions(width, height)
      super(width, height)

      case @direction
      when :vertical
        raise ArgumentError unless @cells.map(&:height_percent).reduce(:+) == 1.0 # Make sure the cells add up to 100%

        # Assign dimensions for each cell
        distribute_vertical_dimension

        # Remove any cells that are below their minimum size. Redistribute dimensions if so
        distribute_vertical_dimension if remove_vertical_minimums

      when :horizontal
        raise ArgumentError unless @cells.map(&:width_percent).reduce(:+) == 1.0 # Make sure the cells add up to 100%

        # Assign dimensions for each cell
        distribute_horizontal_dimension

        # Remove any cells that are below their minimum size. Redistribute dimensions if so
        distribute_horizontal_dimension if remove_horizontal_minimums
      else
        raise ArgumentError
      end
    end

    private

    def remove_vertical_minimums
      remove_any = false
      extra_size = 0.0

      @cells.each do |cell|
        if cell.min_height && cell.height < cell.min_height
          extra_size += cell.height_percent
          @cells.delete(cell)
          remove_any = true
        end
      end

      @cells.each { |cell| cell.height_percent += extra_size / @cells.length} if remove_any
      remove_any
    end

    def remove_horizontal_minimums
      remove_any = false
      extra_size = 0.0

      @cells.each do |cell|
        if cell.min_width && cell.width < cell.min_width
          extra_size += cell.width_percent
          @cells.delete(cell)
          remove_any = true
        end
      end

      @cells.each { |cell| cell.width_percent += extra_size / @cells.length} if remove_any
      remove_any
    end

    def distribute_vertical_dimension
      @cells.each do |cell|
        raise ArgumentError unless cell.width_percent == 1.0 # Make sure each cell covers the entire width
        cell.set_dimensions(@width, (@height * cell.height_percent).round)
      end
    end

    def distribute_horizontal_dimension
      @cells.each do |cell|
        raise ArgumentError unless cell.height_percent == 1.0 # Make sure each cell covers the entire width
        cell.set_dimensions((@width * cell.width_percent).round, @height)
      end
    end

  end
end