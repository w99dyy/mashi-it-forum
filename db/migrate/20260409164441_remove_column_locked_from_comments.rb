class RemoveColumnLockedFromComments < ActiveRecord::Migration[8.1]
  def change
    remove_column :comments, :locked, :boolean, default: false
  end
end
