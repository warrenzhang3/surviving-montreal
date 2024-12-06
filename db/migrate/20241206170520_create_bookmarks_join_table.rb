class CreateBookmarksJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_table :bookmarks, id: false do |t|
      t.bigint :user_id, null: false
      t.bigint :article_id, null: false
    end

    add_index :bookmarks, [:user_id, :article_id], unique: true
  end
end
