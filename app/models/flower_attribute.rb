# == Schema Information
#
# Table name: flower_attributes
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_flower_attributes_on_name  (name)
#

class FlowerAttribute < ApplicationRecord
end
