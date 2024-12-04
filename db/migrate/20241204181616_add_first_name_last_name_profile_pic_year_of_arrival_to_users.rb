class AddFirstNameLastNameProfilePicYearOfArrivalToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :profile_pic, :string
    add_column :users, :year_of_arrival, :date
  end
end
