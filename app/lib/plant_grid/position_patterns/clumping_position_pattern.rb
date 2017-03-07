module PlantGrid
  module PositionPatterns
    class ClumpingPositionPattern < PositionPattern
      def position
        # Determine the wavelength
        plant_width = @plant.width_with_horizontal_spacing

        start_x = plant_width / 2
        start_y = plant_width / 2 #@height / 2
        rows = (@height / plant_width).to_i

        last_posns = []

        (0..rows).each do |row_idx|
          (start_x.to_i..(@width.to_i - start_x.to_i)).each do |posn_x|
            posn_y = start_y +
                      row_idx * plant_width +
                      Math.sin(posn_x / (plant_width/8) + (row_idx % 2) * Math::PI) *
                        plant_width / 2

            if last_posns.empty? || no_overlap(last_posns, {x: posn_x, y: posn_y}, plant_width * 0.75)
              next if posn_y < plant_width / 2 || posn_y > @height - plant_width / 2 || posn_x < plant_width / 2 || posn_x > @width - plant_width / 2
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
        Rails.logger.warn a
        Rails.logger.warn b
        dist = ((a[:x] - b[:x]) ** 2 + (a[:y] - b[:y]) ** 2) ** 0.5
        Rails.logger.warn dist
        dist
      end

    end
  end
end
