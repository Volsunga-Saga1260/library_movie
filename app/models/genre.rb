class Genre < ApplicationRecord
  has_many :movies
  # ジャンルの名前の空白登録の制限
  validates :name, presence: true

end
