class AddSeenToUserBadges < ActiveRecord::Migration[7.1]
  def change
    add_column :user_badges, :seen, :boolean, null: false, default: false
  end
end
