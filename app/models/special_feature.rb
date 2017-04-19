# == Schema Information
#
# Table name: special_features
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_special_features_on_name  (name)
#

class SpecialFeature < ApplicationRecord
end
