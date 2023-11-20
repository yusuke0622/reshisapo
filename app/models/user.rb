class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  has_one_attached :user_icon
  
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  

 def active_for_authentication?
    super && (is_deleted == false) 
 end
 
 #写真
 def no_image
   unless user_icon.attached?
   file_path = Rails.root.join('app/assets/images/no_image.jpg')
   user_icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
 end
 
 #検索
 def self.looks(search, word)
   if search == "perfect_match"
     @user = User.where("name LIKE?", "#{word}")
   elsif search == "forward_match"
     @user = User.where("name LIKE?", "#{word}%")
   elsif  search == "backward_match"
     @user = User.where("name LIKE?", "%#{word}")
   elsif search == "partial_match"
     @user = User.where("name LIKE?", "%#{word}%")
   else
     @user = User.all
   end
 end
  
end