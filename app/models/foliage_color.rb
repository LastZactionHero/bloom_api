# == Schema Information
#
# Table name: foliage_colors
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_foliage_colors_on_name  (name)
#

class FoliageColor < ApplicationRecord
end
