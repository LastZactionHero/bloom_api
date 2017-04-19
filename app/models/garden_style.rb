# == Schema Information
#
# Table name: garden_styles
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_garden_styles_on_name  (name)
#

class GardenStyle < ApplicationRecord
end
