class CreateJoinTableUsersEvents < ActiveRecord::Migration[7.1]
  def change
    create_join_table :users, :events do |t|
      t.index [:user_id, :event_id], unique: true
      t.index [:event_id, :user_id]
    end
  end
end
