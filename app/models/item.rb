class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase


  validates :item_name, presence: true

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true }
  validates :description, presence: true
end

