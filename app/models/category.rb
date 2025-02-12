class Category < ApplicationRecord
  has_many :posts, dependent: :destroy
  validates :title,presence: {message: "Yazı alanı boş olamaz"}
end
