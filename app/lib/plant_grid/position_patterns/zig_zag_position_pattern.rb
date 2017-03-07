module PlantGrid
  module PositionPatterns
    class ZigZagPositionPattern < PositionPattern
      def position
        # Determine how many plants will fit in this area
        plants_wide = (@width.to_f / (@plant.width_with_horizontal_spacing)).floor
        plants_tall = 1

        # Determine the size of the box containing all plants
        plants_rect_width = @plant.width_with_horizontal_spacing * plants_wide
        plants_rect_height = @plant.width_with_vertical_spacing * 1.5

        # Calculate the offset to start placing plants, centered in the bed
        start_x = ((@width - plants_rect_width) / 2 + @plant.width_with_horizontal_spacing / 2).ceil
        start_y = @height / 2
        zigzag_height = (plants_rect_height - @plant.width_with_vertical_spacing) / 2

        start_position = (@options['start_position'] == 'down') ? 1 : 0

        (0..(plants_wide - 1)).each do |plant_x|
          pos_x = plant_x * @plant.width_with_horizontal_spacing + start_x
          pos_y = start_y + (plant_x % 2 == start_position ? -zigzag_height : zigzag_height )
          @grid[pos_y][pos_x] = @plant
        end
      end
    end
  end
end
