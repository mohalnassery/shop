class Product < ApplicationRecord
 
  belongs_to :user
  belongs_to :category
  has_many :cart_items, dependent: :destroy

  has_one_attached :image

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }

  # You can input more brands finish and condition here
  BRAND = %w{ Ferrari Opel Lenovo Fossil}
  FINISH = %w{ Black White Navy Blue Red Clear Satin Yellow Seafoam }
  CONDITION = %w{ New Excellent Mint Used Fair Poor }

end
