class BedTemplate < ApplicationRecord
  before_validation :parse_config
  validates_presence_of :name
  validates_presence_of :config

  def render(width, height)
    config_hash = JSON.parse(config)
    parent_cell = PlantGrid::BedTemplateParser.parse_cell(config_hash['cell'])
    grid = PlantGrid::Grid.new(parent_cell, width, height)
    PlantGrid::Printer.new(grid).draw
  end

  private

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
