class Movie < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  
  def favorited_by?(customer)
  favorites.where(customer_id: customer.id).exists?
  end
  
  validates :title, presence: true
  validates :original, presence: true
  validates :text, presence: true, length: {maximum: 200}
end
