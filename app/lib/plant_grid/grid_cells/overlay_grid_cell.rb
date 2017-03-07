module PlantGrid
  module GridCells
    class OverlayGridCell < GridCell
      def initialize(width_percent, height_percent, cells, options = {})
        super(width_percent, height_percent, options)
        @cells = cells
      end

      def draw
        grid = (1..@height).map{ Array.new(@width, ' ') }

        placements = [] # store a list of placements to quickly find nearby plants

        @cells.each do |cell|
          # Draw the cell onto a full grid
          cell.set_dimensions(@width, @height)
          cell_grid = cell.draw

          # Overlay plants onto the grid
          cell_grid.each_with_index do |row, row_idx|
            row.each_with_index do |plant, col_idx|
              next unless plant.is_a?(PlantGrid::PlantTemplate)

              grid[row_idx][col_idx] = plant # Place the plant on the grid
              placements << {label: plant.label, x: row_idx, y: col_idx}

              # Remove any plants of different type that intersect it
              overlapping_placements = placements.select do |placement|
                if placement[:label] == plant.label # same plant type, don't remove it
                  false
                else
                  distance(placement, {x: row_idx, y: col_idx}) < plant.width_with_horizontal_spacing
                end
              end
              overlapping_placements.each do |overlapping_placement|
                grid[overlapping_placement[:x]][overlapping_placement[:y]] = '-'
              end
            end
          end
        end

        grid
      end

      private

      def distance(a, b)
        ((a[:x] - b[:x]) ** 2 + (a[:y] - b[:y]) ** 2) ** 0.5
      end

    end
  end
end
