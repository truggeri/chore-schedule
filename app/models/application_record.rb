class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :family, ->(fam) { where(family: fam) if fam.present? }
end
