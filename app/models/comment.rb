class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :content, presence: {message: "kısmı boş olamaz!"},uniqueness: {message: "bu yorum zaten eklenmiş!"}
end
