class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :location
      t.date :event_date
      t.integer :number_of_people
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
