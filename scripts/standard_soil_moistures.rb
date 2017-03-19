puts WateringNeed.all.map{|wn| "#{wn.id} #{wn.plants.count} #{wn.name}"}
#
# 1 2626 Water Weekly
# 2 1110 Water occasionally, once established
# 3 48 Watering during extreme heat
# 4 0
# 5 145 Moist soil, not soggy
# 6 55 Semi most soil
# 7 27 Little watering, once established
# 8 267 Water regularly
# 9 348 Constantly moist soil
# 10 1 Dry soil
# 11 2 Well drained soil
# 12 302 Water when top of soil is dry

# Tom's Notes
# -Constantly Moist soil - Wet or moist
# -Dry soil - Dry
# -Little Watering once established - Normal but this sounds more specific to the plant not soil.
# -Moist Soil but not soggy - Wet or moist
# -Semi Moist Soil - Wet or moist
# -Water occasionally once established- Dry but could also just be a finicky plant.  I would like to eliminate this category like "Little watering once established".  It's more about the plant than soil type
# -Water regularly - Dry or but once again specific to plant needs
  # -Water weekly - Dry or specific to plant needs
# -Water when top of soil is dry - Super Dry
# -Well drained soil - Dry

WateringNeed.all.each do |wn|
  soil_moisture = {
    "Water Weekly" => "dry|normal",
    "Water occasionally, once established" => "wet|normal|dry",
    "Watering during extreme heat" => "wet|normal|dry",
    "Moist soil, not soggy" => "wet|normal",
    "Semi most soil" => "wet|normal",
    "Little watering, once established" => "normal",
    "Water regularly" => "wet|normal|dry",
    "Constantly moist soil" => "wet|normal",
    "Dry soil" => "dry",
    "Well drained soil" => "dry",
    "Water when top of soil is dry" => "dry"
  }[wn.name]
  puts soil_moisture

  wn.plants.each do |plant|
    plant.soil_moisture = soil_moisture
    plant.save
  end
end; 0
