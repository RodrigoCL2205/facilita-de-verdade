class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :requeriments
  has_many :work_periods

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

end
