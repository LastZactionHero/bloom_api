module PlantGrid
  module PositionPatterns
    class RectPositionPattern < PositionPattern
      def position
        # Determine how many plants will fit in this area
        plants_wide = (@width.to_f / (@plant.width_with_horizontal_spacing)).floor
        plants_tall = (@height.to_f / (@plant.width_with_vertical_spacing)).floor

        # Determine the size of the box containing all plants
        plants_rect_width = @plant.width_with_horizontal_spacing * plants_wide
        plants_rect_height = @plant.width_with_vertical_spacing * plants_tall

        # Calculate the offset to start placing plants, centered in the bed
        start_x = ((@width - plants_rect_width) / 2 + @plant.width_with_horizontal_spacing / 2).ceil
        start_y = ((@height - plants_rect_height) / 2 + @plant.width_with_vertical_spacing / 2).ceil

        (0..(plants_wide - 1)).each do |plant_x|
          (0..(plants_tall - 1)).each do |plant_y|
            pos_x = plant_x * @plant.width_with_horizontal_spacing + start_x
            pos_y = plant_y * @plant.width_with_vertical_spacing + start_y
            @grid[pos_y][pos_x] = @plant
          end
        end
      end
    end
  end
end
