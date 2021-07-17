class Movie < ApplicationRecord
   belongs_to :customer
   
   validates :title, presence: true
   validates :text, presence: true, length: {maximum: 200}
end
