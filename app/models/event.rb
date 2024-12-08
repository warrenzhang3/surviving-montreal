# app/models/event.rb
class Event < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :users

  validates :title, presence: true
  validates :description, presence: true

  has_many_attached :images
end
