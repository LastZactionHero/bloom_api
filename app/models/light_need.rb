# == Schema Information
#
# Table name: light_needs
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_light_needs_on_name  (name)
#

class LightNeed < ApplicationRecord
  has_many :plants
end
