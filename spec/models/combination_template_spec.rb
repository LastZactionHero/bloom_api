# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CombinationTemplate, type: :model do
  describe 'starting_plants' do
    it 'returns a list of starting plants with tooltips' do
      combination_template = FactoryGirl.create(:combination_template)
      starting_plants = combination_template.starting_plants
      starting_plants.each do |starting_plant|
        expect(starting_plant.plant.kind_of?(Plant)).to be_truthy
        expect(starting_plant.tooltip.kind_of?(String)).to be_truthy
        expect(starting_plant.area.kind_of?(Float)).to be_truthy
        expect(starting_plant.placement.kind_of?(String)).to be_truthy
      end
    end

    it 'sets a list of starting_plants' do
      combination_template = FactoryGirl.create(:combination_template, starting_plants: [])
      combination_template.starting_plants = (1..3).to_a.map do |i|
        OpenStruct.new(tooltip: "Tooltip #{i}",
                       plant: FactoryGirl.create(:plant, permalink: "permalink_#{i}"),
                       area: 0.5,
                       placement: :lone)
      end

      expect(combination_template[:starting_plants]).to eq('[{"tooltip":"Tooltip 1","permalink":"permalink_1","area":0.5,"placement":"lone"},{"tooltip":"Tooltip 2","permalink":"permalink_2","area":0.5,"placement":"lone"},{"tooltip":"Tooltip 3","permalink":"permalink_3","area":0.5,"placement":"lone"}]')
    end
  end
end
