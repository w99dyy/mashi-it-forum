class Avo::Resources::Comment < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: q, m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user, as: :text do
      link_to record.user.username, avo.resources_user_path(record.user)
    end
    field :body, as: :trix
    field :user_id, as: :number
    field :post_id, as: :number
  #  field :comments_count, as: :number
    field :parent_id, as: :number
    field :pinned, as: :boolean
  #  field :quoted_comment_id, as: :number
    field :images, as: :files
    field :post, as: :belongs_to
    field :user, as: :belongs_to
    field :parent, as: :belongs_to
    field :quoted_comment, as: :belongs_to
    field :replies, as: :has_many
  end
end
