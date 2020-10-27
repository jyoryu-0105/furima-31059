class UserPurchase
  include ActiveModel::Model
  attr_accessor :token, :item_id, :user_id,:postal_code, :prefecture_id, :city, :house_number, :building, :phone_number

  with_options presence: true do
    validates :city
    validates :house_number
    validates :token
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: { with: /\A0\d{9,10}\z/, message: "is invalid. NO hyphen(-)"}
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, house_number: house_number, building: building, phone_number: phone_number, purchase_id: purchase.id)
  end
end
