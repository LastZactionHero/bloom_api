# == Schema Information
#
# Table name: combination_templates
#
#  id              :integer          not null, primary key
#  starting_plants :jsonb
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CombinationTemplate < ApplicationRecord
end
