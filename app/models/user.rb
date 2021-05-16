class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  has_many :photos, dependent: :destroy
  has_many :answers
  has_many :likes
  has_many :best_answers, through: :likes, source: :answer
  
  def like(answer)
    self.likes.find_or_create_by(answer_id: answer.id)
  end
  
  def unlike(answer)
    like = self.likes.find_by(answer_id: answer.id)
    like.destroy if like
  end
    
  def best_answers?(answer)
    self.best_answers.include?(answer)
  end
  
end
