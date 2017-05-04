# frozen_string_literal: true

# Controller for CombinationTemplate
class CombinationTemplatesController < ApplicationController
  def index
    combination_templates = CombinationTemplate.all
    body = combination_templates.map do |combination_template|
      {
        id: combination_template.id,
        starting_plants: combination_template.starting_plants.map do |sp|
          {
            tooltip: sp.tooltip,
            plant: PlantSerializer.new(sp.plant).to_json
          }
        end
      }
    end
    render status: 200, json: body
  end
end
