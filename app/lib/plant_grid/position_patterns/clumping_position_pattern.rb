module PlantGrid
  module PositionPatterns
    class ClumpingPositionPattern < PositionPattern
      def position
        # Determine the wavelength

        start_x = @plant.width_with_horizontal_spacing / 2
        start_y = @plant.width_with_horizontal_spacing / 2 #@height / 2
        rows = (@height / @plant.width_with_horizontal_spacing).to_i

        last_posns = []

        # (0..rows).each do |row_idx|
          (start_x.to_i..(@width.to_i - start_x.to_i)).each do |posn_x|
            posn_y = start_y + Math.tan(posn_x / (@plant.width_with_horizontal_spacing / 4)) * @plant.width_with_horizontal_spacing / 2

            if last_posns.empty? || no_overlap(last_posns, {x: posn_x, y: posn_y}, @plant.width_with_horizontal_spacing)
              next if posn_y < 0 || posn_y > @height || posn_x < 0 || posn_x > @width
              @grid[posn_y][posn_x] = @plant
              last_posns << {x: posn_x, y: posn_y}
            end
          end
        # end
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