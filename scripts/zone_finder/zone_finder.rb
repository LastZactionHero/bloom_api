require 'rest-client'
require 'csv'

lines = File.readlines('./us_postal_codes.csv'); 0
lines.shift
zipcodes = lines.map{|l| l.force_encoding("UTF-8").split(",")[0]}.select{|z| z.length == 5 }


zipcodes.each_with_index do |zipcode, idx|
  puts "#{zipcode} (#{idx}/#{zipcodes.count})"

  url = "https://garden.org/nga/zipzone/index.php?zip=#{zipcode}&q=find_zone&submit=Go+%3E"
  response = RestClient.get(url)
  zone = response.body.to_s.scan(/(?<=Zone: )[0-9]+[A-Z]+/).first || 'XX' 

  out_file = File.open('./zipcode_zones.csv', 'a')
  out_file << "#{zipcode},#{zone}\n"
  out_file.close
end