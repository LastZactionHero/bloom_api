require 'rest-client'
require 'csv'

api_key = 'xxx'

Plant.where(image_url: 'Undefined').each_with_index do |plant, idx|
  puts "Plant: #{plant.common_name}, #{idx}"

  query = URI.escape(plant.common_name)
  url = "https://api.cognitive.microsoft.com/bing/v5.0/images/search?q=#{query}"
  response = RestClient.get(url, {"Ocp-Apim-Subscription-Key" => key})
  body = JSON.parse(response.body)
  image_urls = body['value'].map{|e| e['contentUrl']}

  file = File.open('./missing_image_urls.txt', 'a')
  file << "Plant: #{plant.permalink}\n"
  image_urls.each do |image_url|
    file << image_url
    file << "\n"
  end
  file << "\n"
  file.close
end; 0
