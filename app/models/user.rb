class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i, message: 'must contain both letters and numbers' }
  validates_format_of :last_name, :first_name, with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, presence: true
  validates_format_of :last_name_kana, :first_name_kana, with: /\A[ァ-ヶー－]+\z/, presence: true

  has_many :items
  has_many :purchases

end
