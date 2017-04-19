# == Schema Information
#
# Table name: growth_rates
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_growth_rates_on_name  (name)
#

class GrowthRate < ApplicationRecord
end
