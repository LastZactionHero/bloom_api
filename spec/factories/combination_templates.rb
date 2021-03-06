# frozen_string_literal: true

FactoryGirl.define do
  factory :combination_template do
    starting_plants do
      (3..5).to_a.map do |i|
        plant = FactoryGirl.create(:plant)
        OpenStruct.new(plant: plant, tooltip: "Plant tooltip #{i}", area: rand.round(2), placement: [:lone, :short_front, :tall_back].sample)
      end
    end
  end
end
