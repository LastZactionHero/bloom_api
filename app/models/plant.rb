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
end
