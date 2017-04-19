# == Schema Information
#
# Table name: zones
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_zones_on_name  (name)
#

class Zone < ApplicationRecord
end
