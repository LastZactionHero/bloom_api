class BedTemplate < ApplicationRecord
  before_validation :parse_config
  validates_presence_of :name
  validates_presence_of :config

  def design_size
    @design_size ||= JSON.parse(config)['size']['design']
  end

  def render(width, height, plant_mapping = nil)
    config_hash = JSON.parse(config)

    recurse_apply_plant_mapping_to_cell(config_hash['cell'], plant_mapping) if(plant_mapping)

    parent_cell = PlantGrid::BedTemplateParser.parse_cell(config_hash['cell'])
    grid = PlantGrid::Grid.new(parent_cell, width, height)
    PlantGrid::Printer.new(grid).draw
  end

  private

  def recurse_apply_plant_mapping_to_cell(cell, plant_mapping)
    if(cell['type'] == 'CompositeGridCell')
      cell['children'].each{|child| recurse_apply_plant_mapping_to_cell(child, plant_mapping)}
    elsif(cell['type'] == 'PlantGridCell')
      template_plant = cell['plant']
      plant = plant_mapping[template_plant['label']]
      return unless plant

      template_plant['width'] = plant.avg_width
    end
  end

  def parse_config
    begin
      config_hash = JSON.parse(config)
    rescue JSON::ParserError => e
      errors.add(:config, 'is not valid JSON')
      return
    end

    self.name = config_hash['name']

    begin
      PlantGrid::BedTemplateParser.parse_cell(config_hash['cell']) # Make sure the cell is parseable
    rescue ArgumentError => e
      errors.add(:config, 'is not a valid template')
    end
  end
end
