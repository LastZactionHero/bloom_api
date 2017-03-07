module PlantGrid
  module PositionPatterns
    class ClumpingPositionPattern < PositionPattern
      OVERLAP_PERCENTAGE = 0.75
      PLANT_FREQUENCY_DIVIDER = 8

      def position
        plant_width = @plant.width_with_horizontal_spacing

        # Pick starting points, determine the number of rows
        start_x = plant_width / 2
        start_y = plant_width / 2
        rows = (@height / plant_width * 2).to_i

        # Maintain a list of plant placements to prevent overlap
        last_posns = []

        # For each row...
        (0..rows).each do |row_idx|
          # For each column...
          (start_x.to_i..(@width.to_i - start_x.to_i)).each do |posn_x|

            # Calculate the Y position
            posn_y = start_y +
                      row_idx * plant_width / 2 +
                      Math.sin(posn_x / (plant_width / PLANT_FREQUENCY_DIVIDER) + (row_idx % 2) * Math::PI) *
                        plant_width / 2

            # Place the plant if it doesn't overlap with an existing plant (or does within acceptable range)
            if last_posns.empty? || no_overlap(last_posns, {x: posn_x, y: posn_y}, plant_width * OVERLAP_PERCENTAGE)
              # Must be in bounds
              next if posn_y < plant_width / 2 ||
                        posn_y > @height - plant_width / 2 ||
                        posn_x < plant_width / 2 ||
                        posn_x > @width - plant_width / 2

              @grid[posn_y][posn_x] = @plant
              last_posns << {x: posn_x, y: posn_y}
            end
          end
        end
      end

      private

      def no_overlap(positions, current, spacing)
        positions.each do |position|
          return false if distance(position, current) < spacing
        end
        true
      end

      def distance(a, b)
        ((a[:x] - b[:x]) ** 2 + (a[:y] - b[:y]) ** 2) ** 0.5
      end

    end
  end
end
