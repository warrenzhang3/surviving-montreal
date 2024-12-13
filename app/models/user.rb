class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_pic
  has_and_belongs_to_many :events
  has_and_belongs_to_many :bookmarked_articles, class_name: 'Article', join_table: :bookmarks

  has_many :articles, dependent: :destroy
  has_many :user_badges
  has_many :badges, through: :user_badges

  def name
    "#{first_name} #{last_name}".strip
  end

  def award_badge(badge_name)
    badge = Badge.find_by(name: badge_name)
    unless self.badges.include?(badge)
      self.badges << badge
      Rails.logger.info "Badge #{badge_name} awarded to #{self.email}"
    end
  end

  def check_winter_survival_badge
    if self.badges.where(name: ['First Article', 'Attend Your First Event', 'First Event Create']).count >= 3
      award_badge('Survive Your First Winter')
    end
  end

  def unseen_badges_count
    user_badges.where(seen: false).count
  end
end
