class Insured < ApplicationRecord
  belongs_to :requeriment, optional: true

end
