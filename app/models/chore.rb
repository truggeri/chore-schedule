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
#  family_id      :bigint(8)
#
# Indexes
#
#  index_chores_on_category_id   (category_id)
#  index_chores_on_family_id     (family_id)
#  index_chores_on_preform_next  (perform_next)
#

class Chore < ApplicationRecord
  belongs_to :category, counter_cache: :chore_count, optional: true
  belongs_to :family
  has_many   :chore_performance_logs, dependent: :destroy

  validates :description, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :family, presence: true
  enum frequency_type: { days: 0, weeks: 1, months: 2 }
  validates :frequency, numericality: { greater_than: 0 }

  before_create :set_first_time
  before_save   :adjust_perform_next

  def set_first_time
    self.perform_next = Time.now.utc + frequency_to_time
  end

  def days_until_due
    (perform_next - Time.now).to_i / 86_400 # seconds in a day
  end

  def frequency_to_time
    eval("#{frequency}.#{frequency_type}")
  end

  def adjust_perform_next
    self.perform_next = last_performed + frequency_to_time if last_performed.present?
  end

  def self.front_page(limit: 5)
    all.order(perform_next: :asc).limit(limit)
  end

  #
  # Should be in a decorator
  #
  def last_performed_string
    return "never" if last_performed.blank?
    last_performed&.strftime("%a, %B %e %Y")
  end

  def perform_next_string
    perform_next&.strftime("%a, %B %e %Y")
  end
end
