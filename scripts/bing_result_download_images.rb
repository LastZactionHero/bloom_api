def unescape_url(raw_url)
  URI.unescape(raw_url.rpartition("r=").last.partition("&p").first)
end

file = File.open('./scripts/missing_image_urls.txt', 'r')
body = file.read
file.close

plants_raw = body.split('Plant: ')
plants_raw.shift

plants = plants_raw.map do |plant_raw|
  plant_raw_lines = plant_raw.split("\n").select{|l| l.present?}
  permalink = plant_raw_lines.shift
  urls = plant_raw_lines.select{|url| url.include?('.jpg')}
  {
    permalink: permalink,
    urls: urls
  }
end

plants.each_with_index do |plant, idx|
  puts "#{idx}: #{plant[:permalink]}"
  next if idx < 108
  next if plant[:urls].empty?
  `curl #{unescape_url(plant[:urls][0])} > ./scripts/plants_images/#{plant[:permalink]}.jpg`
  `curl #{unescape_url(plant[:urls][1])} > ./scripts/plants_images/secondary/#{plant[:permalink]}.jpg` if plant[:urls][1].present?
  `curl #{unescape_url(plant[:urls][2])} > ./scripts/plants_images/secondary/#{plant[:permalink]}_2.jpg` if plant[:urls][2].present?
  `curl #{unescape_url(plant[:urls][3])} > ./scripts/plants_images/secondary/#{plant[:permalink]}_3.jpg` if plant[:urls][3].present?
end
