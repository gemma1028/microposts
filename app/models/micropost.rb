class Micropost < ActiveRecord::Base
  belongs_to :user

  has_many :favorites
  has_many :favoriting_users, through: :favorites, source: :user

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  mount_uploader :image, ImageUploader
  
  def favorited_by?(user)  
   favoriting_users.include?(user) 
  end 
    
  def favorite(user) 
   favorites.find_or_create_by(user_id: user.id) 
  end 
    
  def unfavorite(user) 
   favorites.find_by(user_id: user.id).try(:destroy) 
  end 

end