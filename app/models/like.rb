class Like < ApplicationRecord
  belongs_to :customer
  belongs_to :liker, class_name: 'Customer'

  validates :customer_id, presence: true
  validates :liker_id, presence: true
end
