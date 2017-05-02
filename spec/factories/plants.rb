FactoryGirl.define do
  factory :plant do
    common_name "Shruby #{ SecureRandom.hex }"
    permalink { SecureRandom.hex }
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
    light_need_id 1
    watering_need nil
    similarity_index 0.1
  end
end
