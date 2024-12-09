# app/models/article.rb
class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :description, presence: true

  has_many_attached :images
  has_many :comments, dependent: :destroy
end
