# == Schema Information
#
# Table name: families
#
#  id         :bigint(8)        not null, primary key
#  active     :boolean          default(TRUE), not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class FamilyTest < ActiveSupport::TestCase
  def setup
    @family = create(:family)
  end

  test "name not nil" do
    @family.name = [nil, ""].sample
    assert(!@family.valid?)
  end

  test "name length 100" do
    @family.name = FFaker::Lorem.characters(101)
    assert(!@family.valid?)
  end

  test "name is unique" do
    second_family = build(:family, name: @family.name)
    assert(!second_family.valid?)
  end
end
