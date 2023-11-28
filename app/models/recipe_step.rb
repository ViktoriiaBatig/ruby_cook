class RecipeStep < ApplicationRecord
  belongs_to :recipe
  validates :position, presence: true
  mount_uploader :image, ImageUploader

  default_scope -> { order(position: :asc) }
end
