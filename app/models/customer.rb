class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :movies, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :likes
  has_many :likers, through: :likes, source: :liker
  has_many :reverse_of_likes, class_name: 'Like', foreign_key: 'liker_id'
  has_many :likers, through: :reverse_of_likes, source: :customer
  
  def liker(other_customer)
    unless self == other_customer
      self.likes.find_or_create_by(liker_id: other_customer.id)
    end
  end

  def unliker(other_customer)
    like = self.likes.find_by(liker_id: other_customer.id)
    like.destroy if like
  end

  def liker?(other_customer)
    self.likers.include?(other_customer)
  end
   
   attachment :profile_image
   
   validates :name, presence: true, length: {maximum: 20, minimum: 2}, uniqueness: true
   validates :introduction, length: {maximum: 50}
end
