require 'csv'

namespace :data_dump do
  desc 'Plants Data Dump'
  task :plants => :environment do
    CSV.open("#{Rails.root}/plants.csv", 'wb') do |csv|
      csv << [
        'ID',
        'Permalink',
        'Common Name',
        'Height',
        'Width',
        'Leave Type ID',
        'Growth Rate ID',
        'Flower Color ID',
        'Foliage Color ID',
        'Light Need ID',
        'Watering Need ID',
        'Favorite',
        'Soil Moisture ID',
        'Lighting',
        'Plant Type ID',
        'Zones',
        'Special Features IDs'
      ]
      Plant.all.each do |plant|
        csv << [plant.id,
                plant.permalink,
                plant.common_name.gsub(/[^A-z ]/, ""),
                plant.avg_height,
                plant.avg_width,
                plant.leave_type_id,
                plant.growth_rate_id,
                plant.flower_color_id,
                plant.foliage_color_id,
                plant.light_need_id,
                plant.watering_need_id,
                plant.favorite,
                plant.soil_moisture,
                plant.lighting,
                plant.plant_type_id,
                plant.zones.map(&:name).join(','),
                plant.special_features.pluck(:id).join(',')]
      end
    end
  end
end