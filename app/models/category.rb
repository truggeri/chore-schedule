# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
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

class Category < ApplicationRecord
  has_many :chores

  validates :color, format: { with: /[0-9A-Fa-f]{6}/ }, allow_nil: true
  validates :name, presence: true, uniqueness: true

  before_validation :add_color, on: :create
  after_initialize  :add_color if :new_record?

  private

  def add_color
    if color.blank?
      self.color = ""
      3.times.each { self.color += Random.rand(0..255).to_s(16) }
    end
  end
end
