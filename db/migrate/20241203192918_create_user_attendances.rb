class CreateUserAttendances < ActiveRecord::Migration[7.1]
  def change
    create_table :user_attendances do |t|
      t.date :booking_date
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
