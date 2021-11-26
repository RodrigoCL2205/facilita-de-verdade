class Score < ApplicationRecord
  belongs_to :requeriment
  belongs_to :work_period
end
