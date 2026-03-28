module ApplicationHelper
    def user_has_badges?(user, badge_name)
        return false unless user && user.badges.present?

        user.badges.any? { |badge| badge.name == badge_name }
    end
end
