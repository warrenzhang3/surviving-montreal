class RemoveIconFromBadges < ActiveRecord::Migration[7.1]
  def change
    remove_column :badges, :icon, :string
  end
end
