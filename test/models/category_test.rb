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
#
# Indexes
#
#  index_categories_on_name  (name)
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
