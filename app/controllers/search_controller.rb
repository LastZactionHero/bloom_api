class SearchController < ApplicationController
  RECORDS_PER_PAGE = 24
  SIMILAR_COUNT = 10

  def similar
    plant = Plant.find_by(permalink: params[:permalink])
    render status: 404, json: {} and return unless plant

    zone = nil
    if params[:zone]
      zone = Zone.find_by(name: params[:zone])
      render status: 400, json: { errors: { zone: ['is not valid'] } } and return unless zone
    end

    result_count = (params[:result_count] || SIMILAR_COUNT).to_i
    similar_plants = plant.find_similar(result_count, zone: zone)

    render status: 200, json: similar_plants.map { |p| PlantSerializer.new(p).to_json }
  end

  def random
    plants_query = Plant.where('avg_width > 0 AND avg_height > 0')

    zone = nil
    if params[:zone]
      zone = Zone.find_by(name: params[:zone])
      render status: 400, json: { errors: { zone: ['is not valid'] } } and return unless zone
      plants_query = plants_query.joins(:zones).where('zones.id IN (?)', [zone.id])
    end

    plant = plants_query.all.sample
    render status: 200, json: PlantSerializer.new(plant).to_json
  end

  def query
    sort_order = 'common_name'
    sort_direction = 'ASC'
    page_idx = (params[:page_idx] || 0).to_i

    plants_query = Plant.where('')
    # plants_query = Plant.select("DISTINCT plants.id")

    query = params[:query]

    if query[:common_name].present?
      plants_query = plants_query.where("common_name ILIKE ?", "%#{query[:common_name]}%")
    end
    if query[:foliage_colors] && query[:foliage_colors].any?
      plants_query = plants_query.where("foliage_color_id IN (?)", query[:foliage_colors])
    end
    if query[:flower_attributes] && query[:flower_attributes].any?
      plants_query = plants_query.joins(:flower_attributes).where('flower_attributes.id IN (?)', query[:flower_attributes])
    end
    if query[:flower_colors] && query[:flower_colors].any?
      plants_query = plants_query.where("flower_color_id IN (?)", query[:flower_colors])
    end
    if query[:garden_styles] && query[:garden_styles].any?
      plants_query = plants_query.joins(:garden_styles).where('garden_styles.id IN (?)', query[:garden_styles])
    end
    if query[:growth_rates] && query[:growth_rates].any?
      plants_query = plants_query.where("growth_rate_id IN (?)", query[:growth_rates])
    end
    if query[:key_features] && query[:key_features].any?
      plants_query = plants_query.joins(:key_features).where('key_features.id IN (?)', query[:key_features])
    end
    if query[:leave_types] && query[:leave_types].any?
      plants_query = plants_query.joins(:leave_type).where('leave_types.id IN (?)', query[:leave_types])
    end
    if query[:plant_types] && query[:plant_types].any?
      plants_query = plants_query.where("plant_type_id IN (?)", query[:plant_types])
    end
    if query[:light_needs] && query[:light_needs].any?
      plants_query = plants_query.where("light_need_id IN (?)", query[:light_needs])
    end
    if query[:watering_needs] && query[:watering_needs].any?
      plants_query = plants_query.where("watering_need_id IN (?)", query[:watering_needs])
    end
    if query[:special_features] && query[:special_features].any?
      plants_query = plants_query.joins(:special_features).where('special_features.id IN (?)', query[:special_features])
    end
    if query[:usages] && query[:usages].any?
      plants_query = plants_query.joins(:usages).where('usages.id IN (?)', query[:usages])
    end
    if query[:usages] && query[:usages].any?
      plants_query = plants_query.joins(:usages).where('usages.id IN (?)', query[:usages])
    end
    if query[:zones] && query[:zones].any?
      plants_query = plants_query.joins(:zones).where('zones.id IN (?)', query[:zones])
    end
    if query[:height]['min']
      plants_query = plants_query.where('avg_height >= ?', query[:height]['min'])
    end
    if query[:height]['max']
      plants_query = plants_query.where('avg_height <= ?', query[:height]['max'])
    end
    if query[:width]['min']
      plants_query = plants_query.where('avg_width >= ?', query[:width]['min'])
    end
    if query[:width]['max']
      plants_query = plants_query.where('avg_width <= ?', query[:width]['max'])
    end

    if query[:soil_moisture]
      soil_choices = query[:soil_moisture].split('|')
      soil_query = soil_choices.map{|choice| "soil_moisture LIKE \'%#{choice}%\'"}.join(' OR ')
      plants_query = plants_query.where(soil_query)
    end

    if query[:lighting]
      plants_query = plants_query.where("lighting LIKE ?", "%#{query[:lighting]}%")
    end

    # plants_query = plants_query.select
    # plants_query = plants_query.uniq

    if query[:preference_permalinks] && query[:preference_permalinks].any?
      preference_ids = Plant.where(permalink: query[:preference_permalinks]).pluck(:id)
      preference_sort = preference_ids.map{|id| "plants.id='#{id}' DESC"}.join(', ')
      # plants_query = plants_query.order("plants.id IN (#{preference_ids.join(',')}) DESC, favorite DESC, #{sort_order} #{sort_direction}")
      plants_query = plants_query.order("#{preference_sort}, favorite DESC, #{sort_order} #{sort_direction}").group('plants.id')
    else
      plants_query = plants_query.order("favorite DESC, #{sort_order} #{sort_direction}").group('plants.id')
    end

    record_count = plants_query.length

    plants = plants_query.offset(RECORDS_PER_PAGE * page_idx).limit(RECORDS_PER_PAGE); 0

    render status: 200, json: {
      meta: {
        page_idx: page_idx,
        total_pages: (record_count.to_f / RECORDS_PER_PAGE.to_f).ceil,
        total: record_count
      },
      plants: plants.map { |plant| PlantSerializer.new(plant).to_json }
    }
  end

  def options
    render status: 200, json: {
      leave_types: LeaveType.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      growth_rates: GrowthRate.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      flower_colors: FlowerColor.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      foliage_colors: FoliageColor.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      light_needs: LightNeed.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      key_features: KeyFeature.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      special_features: SpecialFeature.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      zones: Zone.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      usages: Usage.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      garden_styles: GardenStyle.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      flower_attributes: FlowerAttribute.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      plant_types: PlantType.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json },
      watering_needs: WateringNeed.all.order('name ASC').map{|o| GenericNameSerializer.new(o).to_json }
    }
  end

end
