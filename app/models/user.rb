class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # enum role 0 - user, 1 admin
  enum role: [:user, :admin]
  # enum status 0 - active, 1 - banned
  enum status: [:active, :banned]
  
  mount_uploader :avatar, AvatarUploader
  has_many :recipes, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :username, presence: true

  has_many :likes
  has_many :favorites
end
