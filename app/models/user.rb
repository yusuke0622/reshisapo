class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  has_one_attached :user_icon
  
  has_many :recipes, dependent: :destroy
  
         
 def no_image
   unless user_icon.attached?
   file_path = Rails.root.join('app/assets/images/no_image.jpg')
   user_icon.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
 end

end