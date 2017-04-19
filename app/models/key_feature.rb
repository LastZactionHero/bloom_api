# == Schema Information
#
# Table name: key_features
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_key_features_on_name  (name)
#

class KeyFeature < ApplicationRecord
end
