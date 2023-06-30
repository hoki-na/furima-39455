class User < ApplicationRecord
  has_many :items
  has_many :purchases
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true

end
