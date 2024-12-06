class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic
  has_and_belongs_to_many :events
  has_and_belongs_to_many :bookmarked_articles, class_name: 'Article', join_table: :bookmarks

  def name
    "#{first_name} #{last_name}".strip
  end
end
