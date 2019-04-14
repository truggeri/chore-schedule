# == Schema Information
#
# Table name: chores
#
#  id             :integer          not null, primary key
#  description    :string           not null
#  frequency      :integer          not null
#  frequency_type :integer          default(NULL), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint
#
# Indexes
#
#  index_chores_on_category_id  (category_id)
#

require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
