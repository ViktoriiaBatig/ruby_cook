class Recipe < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged

    belongs_to :category
    belongs_to :user
    has_many :recipe_steps
    has_many :comments
    has_many :likes

    accepts_nested_attributes_for :recipe_steps, reject_if: :all_blank, allow_destroy: true

    # enum status: [:draft, :moderation, :published]
    mount_uploader :image, ImageUploader
    enum status: [:draft, :moderation, :published]

    has_many :favorites

    # scope moderated, where users in association recipe_moderation is true
    scope :moderated, -> { joins(:user).where(users: { recipe_moderation: true }) }
    scope :unmoderated, -> { joins(:user).where(users: { recipe_moderation: false }) }
    
    def normalize_friendly_id(input)
        input.to_slug.transliterate(:ukrainian).normalize.to_s
    end

    def likes_count
        likes.where(like_type: 'like').count
    end
    
    def dislikes_count
        likes.where(like_type: 'dislike').count
    end
end
