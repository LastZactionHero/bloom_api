# frozen_string_literal: true

# == Schema Information
#
# Table name: combination_templates
#
#  id              :integer          not null, primary key
#  starting_plants :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

# Stores known good plant combinations
class CombinationTemplate < ApplicationRecord
  def starting_plants
    plants_json = JSON.parse(self[:starting_plants])
    plants_json.map do |plant_json|
      OpenStruct.new(
        tooltip: plant_json['tooltip'],
        plant: Plant.find_by(permalink: plant_json['permalink']),
        area: plant_json['area'],
        placement: plant_json['placement']
      )
    end
  end

  def starting_plants=(plants_arr)
    self['starting_plants'] = plants_arr.map do |plant_data|
      {
        tooltip: plant_data.tooltip,
        permalink: plant_data.plant.permalink,
        area: plant_data.area,
        placement: plant_data.placement
      }
    end.to_json
  end
end
