# == Schema Information
#
# Table name: plants
#
#  id                 :integer          not null, primary key
#  common_name        :text
#  scientific_name    :text
#  source_url         :text
#  image_url          :text
#  description        :text
#  avg_height         :float
#  avg_width          :float
#  care_info          :text
#  store_available    :boolean
#  store_url          :text
#  store_cost         :float
#  leave_type_id      :integer
#  growth_rate_id     :integer
#  flower_color_id    :integer
#  foliage_color_id   :integer
#  light_need_id      :integer
#  watering_need_id   :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  watering_needs_raw :text
#  average_size_raw   :text
#  plant_type_id      :integer
#  permalink          :string
#  favorite           :boolean          default(FALSE)
#  soil_moisture      :string
#  lighting           :string
#  similarity_index   :float            default(0.0)
#
# Indexes
#
#  index_plants_on_avg_height        (avg_height)
#  index_plants_on_avg_width         (avg_width)
#  index_plants_on_common_name       (common_name)
#  index_plants_on_favorite          (favorite)
#  index_plants_on_flower_color_id   (flower_color_id)
#  index_plants_on_foliage_color_id  (foliage_color_id)
#  index_plants_on_growth_rate_id    (growth_rate_id)
#  index_plants_on_leave_type_id     (leave_type_id)
#  index_plants_on_light_need_id     (light_need_id)
#  index_plants_on_lighting          (lighting)
#  index_plants_on_permalink         (permalink)
#  index_plants_on_plant_type_id     (plant_type_id)
#  index_plants_on_scientific_name   (scientific_name)
#  index_plants_on_similarity_index  (similarity_index)
#  index_plants_on_soil_moisture     (soil_moisture)
#  index_plants_on_store_available   (store_available)
#  index_plants_on_watering_need_id  (watering_need_id)
#

class Plant < ApplicationRecord
  belongs_to :plant_type, optional: true
  belongs_to :leave_type, optional: true
  belongs_to :growth_rate, optional: true
  belongs_to :foliage_color, optional: true
  belongs_to :flower_color, optional: true
  belongs_to :watering_need, optional: true
  belongs_to :light_need, optional: true
  has_and_belongs_to_many :key_features
  has_and_belongs_to_many :zones
  has_and_belongs_to_many :usages
  has_and_belongs_to_many :special_features
  has_and_belongs_to_many :garden_styles
  has_and_belongs_to_many :flower_attributes

  validates_uniqueness_of :permalink

  before_validation :set_permalink

  def find_similar(count, options = {})
    plants_query = Plant.where('avg_width > 0 AND avg_height > 0')
    plants_query = plants_query.joins(:zones).where('zones.id IN (?)', [options[:zone]]) if options[:zone]

    plant_idx_gt = plants_query.where("similarity_index >= ?", similarity_index).order('similarity_index ASC').limit(count)
    plant_idx_lt = plants_query.where("similarity_index <= ?", similarity_index).order('similarity_index DESC').limit(count)

    similarity_index_abs = similarity_index.abs
    nearest_plants = (plant_idx_gt.to_a + plant_idx_lt.to_a).uniq
    nearest_plants.sort! do |a, b|
      (similarity_index_abs - a.similarity_index.abs).abs <=> (similarity_index_abs - b.similarity_index.abs).abs
    end.first(count)
  end

  def similarity_index
    self[:similarity_index].round(10)
  end

  private

  def set_permalink
    self.permalink ||= common_name.downcase.gsub(/[^a-z ]/, '').gsub(/[^a-z]+/, '_')
  end
end
