class GridCell
  attr_reader :min_width, :min_height, :width, :height
  attr_accessor :width_percent, :height_percent

  def initialize(width_percent, height_percent, options = {})
    @width_percent = width_percent
    @height_percent = height_percent

    @width = nil
    @height = nil
    @min_width = options[:min_width]
    @min_height = options[:min_height]
  end

  def draw
    raise RuntimeError
  end

  def set_dimensions(width, height)
    @width = width
    @height = height
  end
end