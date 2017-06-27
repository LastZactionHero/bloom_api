# frozen_string_literal: true

namespace :combination_template_seed do
  desc 'Seed Combination Templates'
  task seed: :environment do
    [
      [
        { permalink: 'red_satin_coreopsis', tooltip: 'Loose and natural looking mid size perennial, good for massing', placement: :lone, area: 0.10 },
        { permalink: 'wine_roses_weigela', tooltip: 'Mid size deciduous shrub with showy flowers', placement: :lone, area: 0.35 },
        { permalink: 'baths_cheddar_pink', tooltip: 'Small perennial with both striking foliage and blooms', placement: :short_front, area: 0.10 },
        { permalink: 'caramel_coral_bells', tooltip: 'Perennial', placement: :tall_back, area: 0.15 }
      ],
      [
        { permalink: 'korean_spice_viburnum', tooltip: 'Larger shrub used as standalone or back drop for smaller plants', placement: :lone, area: 0.54 },
        { permalink: 'foersters_feather_reed_grass', tooltip: 'Mid size grass used in massing or screening small objects', placement: :tall_back, area: 0.10 },
        { permalink: 'kobold_gayfeather', tooltip: 'Short groundcover/perennial.  Used as the lowest level in layering', placement: :short_front, area: 0.10 }
      ],
      [
        { permalink: 'goldflame_spirea', tooltip: 'Mid size, deciduous, flowering shrub.  Good as a small backdrop or a standalone plant.', placement: :tall_back, area: 0.60 },
        { permalink: 'big_ears_lambs_ear', tooltip: 'Short groundcover/perennial.  Interesting texture with muted color/non showy flowers', placement: :short_front, area: 0.15 }
      ],
      [
        { permalink: 'nordic_inkberry_holly', tooltip: 'Mid size evergreen shrub.  Good as a backdrop or can be trimmed into a hedge', placement: :lone, area: 0.15 },
        { permalink: 'little_spire_russian_sage', tooltip: 'Small to mid size perennial.  Good in massing', placement: :lone, area: 0.45 }
      ],
      [
        { permalink: 'midnight_wine_weigela', tooltip: 'Small, deciduous shrub.  Showy flowers and interesting leaf color', placement: :lone, area: 0.10 },
        { permalink: 'blue_girl_holly', tooltip: 'Mid size, evergreen shrub.  Berries add winter interest', placement: :lone, area: 0.35 },
        { permalink: 'dwarf_korean_lilac', tooltip: 'Very Large, deciduous, flowering shrub.  Produces desirable smell', placement: :lone, area: 0.15 }
      ],
      [
        { permalink: 'green_velvet_boxwood', tooltip: 'Small, evergreen shrub.  One of most popular shrubs', placement: :tall_back, area: 0.15 },
        { permalink: 'little_lime_hardy_hydrangea', tooltip: 'Mid size flowering shrub, natural/showy flowers are long lasting', placement: :lone, area: 0.35 },
        { permalink: 'big_blue_lilac', tooltip: 'Short groundcover/perennial.  Lowest layer of planting', placement: :short_front, area: 0.10 }
      ],
      [
        { permalink: 'double_knock_out_rose', tooltip: 'Deciduous shrub with showy flowers', placement: :lone_1, area: 0.25 },
        { permalink: 'little_henry_dwarf_virginia_sweetspire', tooltip: 'Small deciduous shrub with interesting blooms', placement: :tall_back, area: 0.10 },
        { permalink: 'stella_de_oro_dwarf_daylily', tooltip: 'Small, reblooming, low maintenance perennial', placement: :short_front, area: 0.05 }
      ],
      [
        { permalink: 'alberta_blue_dwarf_alberta_spruce', tooltip: 'Large, evergreen shrub, used mostly for height/shape in landscape', placement: :lone, area: 0.10 },
        { permalink: 'golden_sedum', tooltip: 'Small perennial with showy flowers and interesting texture', placement: :short_front, area: 0.10 },
        { permalink: 'darts_gold_ninebark', tooltip: 'Mid size deciduous shrub with showy flowers and interesting leaf color', placement: :tall_back, area: 0.55 }
      ],
      [
        { permalink: 'dark_green_spreader_yew', tooltip: 'Small, wide evergreen', placement: :lone, area: 0.65 },
        { permalink: 'little_spire_russian_sage', tooltip: 'Large, deciduous shrub with showy flowers.  Classic', placement: :lone, area: 0.10 }
      ]
    ].each do |combination_template_data|
      ct = CombinationTemplate.new
      ct.starting_plants = combination_template_data.map do |plant_data|
        OpenStruct.new(
          plant: Plant.find_by(permalink: plant_data[:permalink]),
          tooltip: plant_data[:tooltip]
        )
      end
      ct.save
    end
  end
end

