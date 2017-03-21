# Filtered Sun - Morning sun category
# Filtered to Full Sun - Morning sun, Afternoon sun, Full Sun
# Filtered to Partial Sun - Morning sun
# Full shade - Full Shade
# Full shade to filtered sun - Full shade & morning sun
# Full shade to Full sun - WHAT THE FUCK ARE THESE CATEGORIES.  I suppose this is every fucking plant that has sunlight hit it.  You know it does get dark every night and that's what they mean.  Rant over.  Every category.  Or check it and nearly eliminate it if possible.
# Full shade to partial sun - Full shade & morning sun
# Full sun - full sun
# Full to partial shade - Full shade & morning sun
# Partial shade - Morning sun
# Partial Shade to Filtered Sun - Morning sun, Afternoon sun
# Partial shade to full sun -  Afternoon sun, full sun
# Partial shade to partial sun - Morning sun
# Partial sun - Morning sun
# Partial sun to full sun - Morning sun, afternoon sun, full sun
# puts LightNeed.all.map{|ln| "#{ln.id}\t#{ln.plants.count}\t#{ln.name}"}

LightNeed.all.each do |ln|
  lighting = {
    "Partial shade to partial sun" => "morning|afternoon",
    "Partial shade to full sun" => "afternoon|full_sun",
    "Full sun" => "full_sun",
    "Full shade to partial sun" => "morning|full_shade",
    "Partial to full sun" => "afternoon|morning|full_sun",
    "Filtered to partial sun" => "morning",
    "Filtered sun" => "morning",
    "Partial sun" => "morning",
    "Full shade to filtered sun" => "full_shade|morning",
    "Partial shade to filtered sun" => "morning|afternoon",
    "Full to partial shade" => "morning|full_shade",
    "Full shade to full sun" => "morning|afternoon|full_sun|full_shade",
    "Full shade" => "full_shade",
    "Filtered to full sun" => "morning|afternoon|full_sun",
    "Partial shade" => "morning"
  }[ln.name]
  ln.plants.update_all({lighting: lighting})
end
