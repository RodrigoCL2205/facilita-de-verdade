class Benefit < ApplicationRecord
  has_many :benefit_summaries
  belongs_to :requeriment
  has_many :self_declarations
  has_many :rural_documents
end
