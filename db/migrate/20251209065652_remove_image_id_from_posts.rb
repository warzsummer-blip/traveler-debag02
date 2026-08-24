class RemoveImageIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :image_id, :string
  end
end
