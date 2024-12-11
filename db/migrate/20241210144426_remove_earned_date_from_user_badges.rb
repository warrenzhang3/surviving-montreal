class RemoveEarnedDateFromUserBadges < ActiveRecord::Migration[7.1]
  def change
    remove_column :user_badges, :earned_date, :date
  end
end
