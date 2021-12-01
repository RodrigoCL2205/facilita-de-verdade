class Score < ApplicationRecord
  belongs_to :requeriment
  belongs_to :work_period

  has_one :user, through: :work_period
end
