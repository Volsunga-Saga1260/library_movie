class Favorite < ApplicationRecord
  
  belongs_to :customer
  belongs_to :movie
  validates_uniqueness_of :movie_id, scope: :customer_id
  
end
