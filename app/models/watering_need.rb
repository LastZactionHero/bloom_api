# == Schema Information
#
# Table name: watering_needs
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_watering_needs_on_name  (name)
#

class WateringNeed < ApplicationRecord
  has_many :plants
end
