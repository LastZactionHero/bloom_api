FactoryGirl.define do
  factory :plant do
    common_name "MyText"
    scientific_name "MyText"
    source_url "MyText"
    image_url "MyText"
    description "MyText"
    avg_height 1.5
    avg_width 1.5
    care_info "MyText"
    store_available false
    store_url "MyText"
    store_cost 1.5
    leave_type_id 1
    growth_rate_id 1
    flower_color_id 1
    foliage_color_id 1
    light_needs_id 1
    watering_needs 1
  end
end
