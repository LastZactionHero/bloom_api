require 'csv'

zone_list = CSV.readlines('./scripts/zone_finder/zipcode_zones.csv')

last_zone = nil
zone_list.each_with_index do |zone_item|
  if zone_item[1] != 'XX'
    last_zone = zone_item[1]
  else
    zone_item[1] = last_zone
  end
end

zone_code = "zone_lookup = {"; 0
zone_list.each do |z|
  zone_code << "\"#{z[0]}\" => \"#{z[1]}\",\n"
end; 0
zone_code << "}"; 0
puts zone_code