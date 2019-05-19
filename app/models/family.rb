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

class Family < ApplicationRecord
  validates :name, uniqueness: true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z0-9 -]+\z/,
                                                                         message: "only allows letters, numbers and -" }

end
