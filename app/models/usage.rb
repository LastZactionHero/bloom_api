# == Schema Information
#
# Table name: usages
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_usages_on_name  (name)
#

class Usage < ApplicationRecord
end
