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

class Chore < ApplicationRecord
  validates :description, presence: true, length: { maximum: 100 }, uniqueness: true
  enum frequency_type: { days: 0, weeks: 1, months: 2 }
  validates :frequency, numericality: { greater_than: 0 }
end
