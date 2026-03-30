module CommentsHelper
  def comment_plain_text(comment)
    html = comment.body.to_s
    html_without_quotes = html.gsub(/<blockquote>.*?<\/blockquote>/m, '')
    ActionController::Base.helpers.strip_tags(html_without_quotes).strip.truncate(300)
  end
end
