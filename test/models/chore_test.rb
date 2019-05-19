# == Schema Information
#
# Table name: chores
#
#  id             :bigint(8)        not null, primary key
#  description    :string           not null
#  frequency      :integer          not null
#  frequency_type :integer          default("days"), not null
#  last_performed :datetime
#  perform_next   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint(8)
#
# Indexes
#
#  index_chores_on_category_id   (category_id)
#  index_chores_on_preform_next  (perform_next)
#

require 'test_helper'

class ChoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
