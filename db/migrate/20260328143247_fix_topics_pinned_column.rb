class FixTopicsPinnedColumn < ActiveRecord::Migration[8.1]
  def change
    Topic.where(pinned: nil).update_all(pinned: false)

    change_column_default :topics, :pinned, false
    change_column_null :topics, :pinned, false

    add_index :topics, :pinned
  end
end
