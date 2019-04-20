# == Schema Information
#
# Table name: chores
#
#  id             :integer          not null, primary key
#  description    :string           not null
#  frequency      :integer          not null
#  frequency_type :integer          default("days"), not null
#  last_performed :datetime
#  perform_next   :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  category_id    :bigint
#
# Indexes
#
#  index_chores_on_category_id   (category_id)
#  index_chores_on_preform_next  ()
#

class Chore < ApplicationRecord
  has_many    :chore_performance_logs, dependent: :destroy
  belongs_to  :category, counter_cache: :chore_count, optional: true

  validates :description, presence: true, length: { maximum: 100 }, uniqueness: true
  enum frequency_type: { days: 0, weeks: 1, months: 2 }
  validates :frequency, numericality: { greater_than: 0 }

  before_create :set_first_time

  def set_first_time
    self.perform_next = Time.now.utc + frequency_to_time
  end

  def frequency_to_time
    eval("#{frequency}.#{frequency_type}")
  end
end
