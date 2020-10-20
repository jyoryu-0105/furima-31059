class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :status, :shipping_cost, :shipping_date, :prefecture
  
  belongs_to :user
  has_one_attached :image
end
