class Comment < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :recipe
    belongs_to :user

    scope :moderated, -> { joins(:user).where(users: { comment_moderation: true }) }
    scope :unmoderated, -> { joins(:user).where(users: { comment_moderation: false }) }
end
