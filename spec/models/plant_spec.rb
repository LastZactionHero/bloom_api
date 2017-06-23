# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plant, type: :model do
  describe :similar do
    before do
      # Create plants on a range of similiarity indexes
      (-5..5).step(0.1).to_a.each do |si|
        FactoryGirl.create(:plant, similarity_index: si)
      end
    end
    # Centermost plant
    let(:plant) { Plant.find_by(similarity_index: 0.0) }

    it 'returns similar plants' do
      # Find the most similar plants
      similar_count = 10
      similiar_plants = plant.find_similar(10)
      expect(similiar_plants.length).to eq(similar_count)

      closest_plants_si = similiar_plants.map(&:similarity_index)
      expect(closest_plants_si).to eq([0.0, 0.1, -0.1, 0.2, -0.2, 0.3, -0.3, 0.4, -0.4, 0.5])
    end

    it 'filters by zone' do
      # Create a plant with a range way outside the bounds but in the proper zone
      zone = FactoryGirl.create(:zone, name: '5')
      plant_in_zone = FactoryGirl.create(:plant,
                                         similarity_index: 100,
                                         zones: [zone])

      similiar_plants = plant.find_similar(10, zone: zone)
      expect(similiar_plants.length).to eq(1)
      expect(similiar_plants[0]['permalink']).to eq(plant_in_zone.permalink)
    end

    it 'filters by max width' do
      current_max_width = Plant.pluck(:avg_width).max

      # Create a plant that is larger than the other plants and the same similarity_index
      larger_plant = FactoryGirl.create(:plant,
                                        similarity_index: plant.similarity_index,
                                        avg_width: current_max_width + 2)

      similiar_plants = plant.find_similar(10, max_width: current_max_width + 1)

      expect(similiar_plants.map(&:permalink)).not_to include(larger_plant.permalink)
    end
  end
end
