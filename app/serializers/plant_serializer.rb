class PlantSerializer < BaseSerializer
  def to_json
    {
      id: @object.id,
      permalink: @object,permalink,
      common_name: @object.common_name,
      scientific_name: @object.scientific_name,
      size: {
        avg_height: @object.avg_height,
        avg_width: @object.avg_width
      },
      image_url: @object.image_url,
      description: @object.description,

      plant_type: @object.plant_type ? GenericNameSerializer.new(@object.plant_type).to_json : {},
      leave_type: @object.leave_type ? GenericNameSerializer.new(@object.leave_type).to_json : {},
      growth_rate: @object.growth_rate ? GenericNameSerializer.new(@object.growth_rate).to_json: {},
      flower_color: @object.flower_color ? GenericNameSerializer.new(@object.flower_color).to_json: {},
      foliage_color: @object.foliage_color ? GenericNameSerializer.new(@object.foliage_color).to_json: {},
      light_need: @object.light_need ? GenericNameSerializer.new(@object.light_need).to_json: {},

      key_features: @object.key_features.map{|f| GenericNameSerializer.new(f).to_json },
      special_features: @object.special_features.map{|f| GenericNameSerializer.new(f).to_json },

      zones: @object.zones.map{|z| GenericNameSerializer.new(z).to_json },
      usages: @object.usages.map{|u| GenericNameSerializer.new(u).to_json },
      garden_styles: @object.garden_styles.map{|s| GenericNameSerializer.new(s).to_json },
      flower_attributes: @object.flower_attributes.map{|f| GenericNameSerializer.new(f).to_json },

      store_available: {
        available: @object.store_available,
        url: @object.store_url,
        cost: @object.store_cost
      },

      watering_needs_raw: @object.watering_needs_raw,
      average_size_raw: @object.average_size_raw
    }
  end
end