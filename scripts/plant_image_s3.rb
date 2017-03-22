Plant.where("image_url != 'Undefined'").each_with_index do |plant, idx|
  plant.image_url = "https://s3-us-west-1.amazonaws.com/images.plantwithbloom.com/#{plant.permalink}.jpg"
  plant.save
end
