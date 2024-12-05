# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :user
  has_one_attached :image_url
  has_and_belongs_to_many :users
  validates :description, presence: true
end
