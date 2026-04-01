class AddQuotedCommentIdToComments < ActiveRecord::Migration[8.1]
  def change
    add_column :comments, :quoted_comment_id, :integer
  end
end
