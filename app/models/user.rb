class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :requeriments
  has_many :work_periods
  has_many :licenses

  # Recebe como argumento o número referente ao mês através do método Date.today.month
  def scores
    @scores = []
    self.work_periods.each do |work_period|
      work_period.scores.each do |score|
        @scores << score
      end
    end
    return @scores
    # month = date.month
    # year = date.year
    # @scores.select! { |score| score.date.month == month && score.date.year == year }
    # @scores.map{ |score| score.score }.reduce(:+)
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
