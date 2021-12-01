class WorkPeriod < ApplicationRecord
  belongs_to :user
  has_many :scores

  validates :program, presence: true, inclusion: ['CEAB', 'PGRP', 'CEAP']
  validates :start_date, presence: true
end
