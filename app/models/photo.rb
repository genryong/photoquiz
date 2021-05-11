class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  validates :user_id, presence: true
  validates :content, presence: true
  validates :image, presence: true
  
  belongs_to :user
  has_many :answers, dependent: :destroy
end
