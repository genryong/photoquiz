class Answer < ApplicationRecord
  validates :content, presence: true
  
  belongs_to :user
  belongs_to :photo
  has_many :likes, dependent: :destroy
end
