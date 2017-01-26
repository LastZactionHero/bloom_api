- Plant
  common_name
  scientific_name
  source_url
  image_url
  description
  avg_height
  avg_width
  care_info
  store_available
  store_url
  store_cost

  habtm zones
  habtm key_features
  habtm usages
  habtm special_features
  habtm flower_attributes
  habtm garden_styles

  belongs_to leave_types
  belongs_to growth_rate
  belongs_to flower_color
  belongs_to foliage_color
  belongs_to light_needs
  belongs_to watering_needs


  - Zone
    name

  - LeaveType
    name

  - GrowthRate
    name

  - FlowerColor
    name

  - FoliageColor
    name

    - Light Needs
      name

  - Watering Needs
    name

  - KeyFeature
    name

  - Usage
    name

  - PlantType
    name

  - SpecialFeature
    name

  - FlowerAttribute
    name

  - GardenStyle
    name
