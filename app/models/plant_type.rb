# == Schema Information
#
# Table name: plant_types
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_plant_types_on_name  (name)
#

class PlantType < ApplicationRecord
end
