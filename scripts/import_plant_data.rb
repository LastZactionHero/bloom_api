require 'csv'

plants_data = CSV.readlines("import_plant_data.csv"); 0
plants_data.delete_at(0); 0

Plant.destroy_all

plants_data.each_with_index do |plant_data, idx|
  puts idx

  plant = Plant.new
  plant.common_name = plant_data[0]
  plant.source_url = plant_data[1]
  plant.scientific_name = plant_data[2]
  plant.image_url = plant_data[3]

  plant.zones << Zone.find_by(name: '1') if plant_data[5] == 'TRUE'
  plant.zones << Zone.find_by(name: '2') if plant_data[6] == 'TRUE'
  plant.zones << Zone.find_by(name: '3') if plant_data[7] == 'TRUE'
  plant.zones << Zone.find_by(name: '4') if plant_data[8] == 'TRUE'
  plant.zones << Zone.find_by(name: '5') if plant_data[9] == 'TRUE'
  plant.zones << Zone.find_by(name: '6') if plant_data[10] == 'TRUE'
  plant.zones << Zone.find_by(name: '7') if plant_data[11] == 'TRUE'
  plant.zones << Zone.find_by(name: '8') if plant_data[12] == 'TRUE'
  plant.zones << Zone.find_by(name: '9') if plant_data[13] == 'TRUE'
  plant.zones << Zone.find_by(name: '10') if plant_data[14] == 'TRUE'
  plant.zones << Zone.find_by(name: '11') if plant_data[15] == 'TRUE'
  plant.zones << Zone.find_by(name: '12') if plant_data[16] == 'TRUE'

  plant.description = plant_data[17]
  plant.light_need = LightNeed.find_by(name: plant_data[18]) if plant_data[18] && plant_data[18].length > 0
  plant.watering_needs_raw = plant_data[19]
  plant.watering_need = nil
  plant.average_size_raw = plant_data[20]
  plant.avg_width = plant_data[21].to_f if plant_data[21] && plant_data[21].length > 0
  plant.avg_height = plant_data[22].to_f if plant_data[22] && plant_data[22].length > 0
  plant.key_features = KeyFeature.where(name: plant_data[23].split(', ')) if plant_data[23] && plant_data[23].length > 0
  plant.usages = Usage.where(name: plant_data[24].split(', ')) if plant_data[24] && plant_data[24].length > 0
  plant.plant_type = PlantType.find_by(name: plant_data[25]) if plant_data[25] && plant_data[25].length > 0
  plant.leave_type = LeaveType.find_by(name: plant_data[26]) if plant_data[26] && plant_data[26].length > 0
  plant.growth_rate = GrowthRate.find_by(name: plant_data[27])  if plant_data[27] && plant_data[27].length > 0
  plant.special_features = SpecialFeature.where(name: plant_data[28].split(', ')) if plant_data[28] && plant_data[28].length > 0
  plant.foliage_color = FoliageColor.find_by(name: plant_data[29]) if plant_data[29] && plant_data[29].length > 0
  plant.flower_color = FlowerColor.find_by(name: plant_data[30]) if plant_data[30] && plant_data[30].length > 0
  plant.flower_attributes = FlowerAttribute.where(name: plant_data[31].split(', ')) if plant_data[31] && plant_data[31].length > 0
  plant.garden_styles = GardenStyle.where(name: plant_data[32].split(', ')) if plant_data[32] && plant_data[32].length > 0
  plant.care_info = plant_data[34]
  plant.store_available = plant_data[35] == 'TRUE'
  plant.store_url = plant_data[36]
  plant.store_cost = plant_data[37].to_f if plant_data[37] && plant_data[37].length > 0
  plant.save
end; 0