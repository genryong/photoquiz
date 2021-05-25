class Photo < ApplicationRecord
  mount_uploader :image, ImageUploader
  
  validates :user_id, presence: true
  validates :content, presence: true
  validates :image, presence: true
  validate  :image_size
  
  belongs_to :user
  has_many :answers, dependent: :destroy
  
  
  private
  
  def image_size
      if image.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
  end
end
