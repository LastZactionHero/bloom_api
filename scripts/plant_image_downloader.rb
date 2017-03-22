Plant.where("image_url != 'Undefined'").each_with_index do |plant, idx|
  puts "Downloading #{idx}"
  `curl #{plant.image_url} > ./plant_images/#{plant.permalink}.jpg`
end
