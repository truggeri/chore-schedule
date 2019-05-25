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
#  account_id   :bigint(8)
#  family_id    :bigint(8)
#
# Indexes
#
#  index_users_on_family_id  (family_id)
#  index_users_on_name       (name)
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
  end

  test "has account" do
    @user.account = nil
    assert(!@user.valid?)
  end

  test "has family" do
    @user.family = nil
    assert(!@user.valid?)
  end

  test "has name" do
    @user.name = nil
    assert(!@user.valid?)
  end
end
