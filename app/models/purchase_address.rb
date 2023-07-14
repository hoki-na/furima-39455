class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :municipality, :house_number, :house_name, :phone_number, :token
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :token

    validates :post_code,format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :municipality, :house_number
    validates :phone_number,format: { with: /\A[0-9]{10,11}\z/, message: 'must be 10 to 11 digits and contain only numbers' }
  end

  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Address.create(post_code:, prefecture_id:, municipality:, house_number:, house_name:, phone_number:, purchase_id: purchase.id)
  end

end