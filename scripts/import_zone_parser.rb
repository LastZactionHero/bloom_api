require 'csv'

COL_ZONE = 4
plants_data = CSV.readlines("import_plant_data.csv"); 0
plants_data.delete_at(0); 0

zone_arrs = plants_data.map do |plant_data|
  zone_arr = Array.new(12, false)
  zone_string = plant_data[COL_ZONE]
  zone_range = zone_string.scan(/[0-9]+/).map{|s| s.to_i}
  zone_range.select!{|z| z > 0}
  if zone_range.length > 0
    zone_range << zone_range[0] if zone_range.length == 1
    (zone_range[0]..zone_range[1]).each do |z_id|
      zone_arr[z_id-1] = true
    end
  end
  zone_arr
end; 0

(0..200).each do |id|
  puts id
  puts plants_data[id][COL_ZONE]
  puts zone_arrs[id].join(',')
end

CSV.open("./parsed_zones.csv", "wb") do |csv|
  zone_arrs.each do |zone_arr|
    csv << zone_arr
  end
end