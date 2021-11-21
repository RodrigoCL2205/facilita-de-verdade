class Requeriment < ApplicationRecord
  belongs_to :user
  belongs_to :insured, optional: true
  belongs_to :benefit, optional: true
end
