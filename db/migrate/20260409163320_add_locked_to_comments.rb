class AddLockedToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :locked, :boolean, default: false
  end
end
