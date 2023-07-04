class Item < ApplicationRecord
  # has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :ship_date
  has_one_attached :image


  validates :image, :item_name, :description, presence: true
  validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :ship_date_id, exclusion: { in: [1], message: "is not a valid option" }
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }

  def was_attached?
    image.attached?
  end
end

