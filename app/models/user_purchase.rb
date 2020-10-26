class UserPurchase
  include ActiveModel::ActiveModel
  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building, :phone_number

  validates :city, :house_number, presence: true

  with_options presence: true do
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: { with: /0\d{10}/, message: "is invalid. NO hyphen(-)"}
  end
end
