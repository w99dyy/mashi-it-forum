class AddPinnedToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :pinned, :boolean, default: false, null: false
    add_index :comments, [ :post_id, :pinned ]
  end
end
