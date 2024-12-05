class RemoveProfilePicFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :profile_pic, :string
  end
end
