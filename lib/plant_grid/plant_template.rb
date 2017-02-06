class PlantTemplate
  attr_reader :label, :width, :horizontal_spacing, :vertical_spacing, :search_query

  def initialize(label, width, horizontal_spacing, vertical_spacing, search_query)
    @label = label
    @width = width.to_f

    @horizontal_spacing = horizontal_spacing.to_f
    @vertical_spacing = vertical_spacing.to_f
    @search_query = search_query
  end

  def width_with_horizontal_spacing
    @width + @horizontal_spacing
  end

  def width_with_vertical_spacing
    @width + @vertical_spacing
  end
end