# == Schema Information
#
# Table name: flower_colors
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_flower_colors_on_name  (name)
#

class FlowerColor < ApplicationRecord
end
