module PlantGrid
  class BedTemplateParser
    attr_reader :name, :design_width, :design_height, :zones, :cell

    def initialize(name, design_width, design_height, zones, cell)
      @name = name
      @design_width = design_width
      @design_height = design_height
      @zones = zones
      @cell = cell
    end

    def self.parse_cell(cell_data)
      case cell_data['type']
      when 'CompositeGridCell'
        PlantGrid::GridCells::CompositeGridCell.new(
          cell_data['width_percent'],
          cell_data['height_percent'],
          cell_data['orientation'].to_sym,
          cell_data['children'].map{|c| parse_cell(c)},
          (cell_data['options'] || {})
        )
      when 'PlantGridCell'
        PlantGrid::GridCells::PlantGridCell.new(
          cell_data['width_percent'],
          cell_data['height_percent'],
          PlantTemplate.new(
            cell_data['plant']['label'],
            cell_data['plant']['width'],
            cell_data['plant']['horizontal_spacing'],
            cell_data['plant']['vertical_spacing'],
            cell_data['plant']['search_query'],
            cell_data['plant']['tooltip'],
            cell_data['plant']['plant_type']
          ),
          {
            'RectPositionPattern' => PlantGrid::PositionPatterns::RectPositionPattern,
            'SingleRowPositionPattern' => PlantGrid::PositionPatterns::SingleRowPositionPattern,
            'ZigZagPositionPattern' => PlantGrid::PositionPatterns::ZigZagPositionPattern,
            'ClumpingPositionPattern' => PlantGrid::PositionPatterns::ClumpingPositionPattern,
          }[cell_data['pattern']],
          (cell_data['options'] || {})
        )
      when 'EmptyGridCell'
        PlantGrid::GridCells::EmptyGridCell.new(
          cell_data['width_percent'],
          cell_data['height_percent'],
          (cell_data['options'] || {})
        )
      when 'OverlayGridCell'
        PlantGrid::GridCells::OverlayGridCell.new(
          cell_data['width_percent'],
          cell_data['height_percent'],
          cell_data['children'].map{|c| parse_cell(c)},
          (cell_data['options'] || {})
        )
      else
        raise ArgumentError
      end
    end

    def self.parse(definition)
      cell_data = definition['cell']
      cell = parse_cell(cell_data)

      BedTemplate.new(
        definition['name'],
        definition['size']['design']['width'],
        definition['size']['design']['height'],
        definition['zones'],
        cell
      )
    end
  end
end
