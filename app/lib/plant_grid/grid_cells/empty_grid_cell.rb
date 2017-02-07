class EmptyGridCell < GridCell
  def initialize(width_percent, height_percent, options = {})
    super(width_percent, height_percent, options)
  end

  def draw
    (1..@height).map{ Array.new(@width, ' ') }
  end
end