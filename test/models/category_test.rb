# == Schema Information
#
# Table name: categories
#
#  id          :bigint(8)        not null, primary key
#  chore_count :integer          default(0), not null
#  color       :string(6)
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  family_id   :bigint(8)
#
# Indexes
#
#  index_categories_on_family_id  (family_id)
#  index_categories_on_name       (name)
#

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = create(:category)
  end

  test "name not nil" do
    @category.name = [nil, ""].sample
    assert(!@category.valid?)
  end

  test "name is unique" do
    other_category = build(:category, name: @category.name)
    assert(!other_category.valid?)
  end

  test "has family" do
    @category.family = nil
    assert(!@category.valid?)
  end

  test "color can be nil" do
    @category.color = nil
    assert(@category.valid?)
  end
end
