class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :status
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :shipping_date
  belongs_to_active_hash :prefecture

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  validates :name, :details, :category, :status, :shipping_cost, :shipping_date, :prefecture, presence: true
  validates :image, presence: { message: 'を選択してください' }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000 }
  validates :category_id, :status_id, :shipping_cost_id, :shipping_date_id, :prefecture_id, numericality: { other_than: 1 ,message: 'を選択してください'}
end
