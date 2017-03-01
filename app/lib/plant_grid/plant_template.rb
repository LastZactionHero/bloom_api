module PlantGrid
  class PlantTemplate
    attr_reader :label, :width, :horizontal_spacing, :vertical_spacing, :search_query, :tooltip, :plant_type

    def initialize(label, width, horizontal_spacing, vertical_spacing, search_query, tooltip, plant_type)
      @label = label
      @width = width.to_f

      @horizontal_spacing = horizontal_spacing.to_f
      @vertical_spacing = vertical_spacing.to_f
      @search_query = search_query
      @tooltip = tooltip
      @plant_type = plant_type
    end

    def width_with_horizontal_spacing
      @width + @horizontal_spacing
    end

    def width_with_vertical_spacing
      @width + @vertical_spacing
    end
  end
end
