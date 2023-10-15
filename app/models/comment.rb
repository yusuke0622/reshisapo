class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :recipe
    has_many :notifications, dependent: :destroy
    
    validates :content, presence: true
end
