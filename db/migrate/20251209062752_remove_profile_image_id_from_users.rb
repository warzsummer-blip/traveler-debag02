class RemoveProfileImageIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :profile_image_id, :string
  end
end
