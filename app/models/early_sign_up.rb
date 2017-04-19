# == Schema Information
#
# Table name: early_sign_ups
#
#  id         :integer          not null, primary key
#  email      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  newsletter :boolean          default(FALSE)
#  zipcode    :string
#

class EarlySignUp < ApplicationRecord
end
