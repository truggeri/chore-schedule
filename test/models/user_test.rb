# == Schema Information
#
# Table name: users
#
#  id           :bigint(8)        not null, primary key
#  chores_total :integer          default(0), not null
#  chores_week  :integer          default(0), not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_name  (name)
#

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
