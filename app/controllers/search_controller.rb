class SearchController < ApplicationController
  RECORDS_PER_PAGE = 20

  def query
    sort_order = 'common_name'
    sort_direction = 'ASC'
    page_idx = 0

    plants_query = Plant.where('')
      .order("#{sort_order} #{sort_direction}")


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
    if query[:light_needs] && query[:light_needs].any?
      plants_query = plants_query.where("light_need_id IN (?)", query[:light_needs])
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

    record_count = plants_query.count

    plants = plants_query.offset(RECORDS_PER_PAGE * page_idx)
      .limit(RECORDS_PER_PAGE)

    render status: 200, json: {
      meta: {
        page_idx: 0,
        total: record_count
      },
      plants: plants.map { |plant| PlantSerializer.new(plant).to_json }
    }
  end

  def options
    render status: 200, json: {
      leave_types: LeaveType.all.map{|o| GenericNameSerializer.new(o).to_json },
      growth_rates: GrowthRate.all.map{|o| GenericNameSerializer.new(o).to_json },
      flower_colors: FlowerColor.all.map{|o| GenericNameSerializer.new(o).to_json },
      foliage_colors: FoliageColor.all.map{|o| GenericNameSerializer.new(o).to_json },
      light_needs: LightNeed.all.map{|o| GenericNameSerializer.new(o).to_json },
      key_features: KeyFeature.all.map{|o| GenericNameSerializer.new(o).to_json },
      special_features: SpecialFeature.all.map{|o| GenericNameSerializer.new(o).to_json },
      zones: Zone.all.map{|o| GenericNameSerializer.new(o).to_json },
      usages: Usage.all.map{|o| GenericNameSerializer.new(o).to_json },
      garden_styles: GardenStyle.all.map{|o| GenericNameSerializer.new(o).to_json },
      flower_attributes: FlowerAttribute.all.map{|o| GenericNameSerializer.new(o).to_json },
    }
  end

end
