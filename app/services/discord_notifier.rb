class DiscordNotifier
    def self.post_created(post)
      webhook_url = ENV["DISCORD_WEBHOOK_URL"]
      return unless webhook_url.present?

      require "net/http"
      require "uri"

        message = {
  content: "📝 **New Post Created!**\n**Title:** #{post.title}\n**Author:** #{post.user.username}\n**Topic:** #{post.topic.title}\n**View:** #{ENV['APP_URL']}/#{post.topic.id}/posts/#{post.id}"
}

      uri = URI.parse(webhook_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.path)
      request["Content-Type"] = "application/json"
      request.body = message.to_json

      Thread.new { http.request(request) rescue nil }
    end
end
