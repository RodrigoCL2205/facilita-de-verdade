class License < ApplicationRecord
  belongs_to :user

  validates :start_date, presence: true
  validates :end_date, presence: true,
            date: { after_or_equal_to: :start_date, message: 'A data fim tem que ser igual ou após a data de início.' },
              on: :create
  validates :tipo, inclusion: ['Licença', 'Férias']
end
