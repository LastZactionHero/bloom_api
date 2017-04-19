# == Schema Information
#
# Table name: leave_types
#
#  id         :integer          not null, primary key
#  name       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_leave_types_on_name  (name)
#

class LeaveType < ApplicationRecord
end
