class Recipe < ApplicationRecord
    # belongs_to :Recipe
    belongs_to :category
    has_many :recipe_tag_relations, dependent: :destroy
    has_many :tags, through: :recipe_tag_relations, dependent: :destroy
    has_many :ingredients, dependent: :destroy
    accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
    has_many :steps, dependent: :destroy
    accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true
    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :notifications. dependent: :destroy

    
    has_one_attached :recipe_image
    has_one_attached :step_image
    
    
    
    #タグ
    def save_tag(sent_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - sent_tags
        new_tags = sent_tags - current_tags
        
        old_tags.each do |old|
            self.tags.delete Tag.find_by(tag_name: old)
        end
        
        new_tags.each do |new|
            recipe_tag = Tag.find_or_create_by(tag_name: new)
            self.tags << recipe_tag
        end
        
    end
    
    # いいね
    def favorited?(user)
        favorites.where(user_id: user.id).exists?
    end
    
    #いいね通知
    def create_notification_like!(current_user)
        temp = Notification.where(['visitor_id = ? and visited_id = ? and recipe_id = ? and action = ?', current_user.id, user_id, id, 'favorite'])
        if temp.blank?
            notification = current_user.active_notifications.new(
                recipe_id: id,
                visited_id: user_id,
                action: 'favorite'
                )
        
            if notification.visitor_id == notification.visited_id
                notification.checked = true
            end
            notification.save if notification.valid?
        end
    end
    
    #コメント通知
    def create_notification_comment!(current_user, comment_id)
        temp_ids = Comment.select(:user_id).where(recipe_id :id).where.not(user_id: current_user.id).distinct
        temp_ids.each do |temp_id|
            save_notification_comment!(current_user, comment_id, temp_id['user_id'])
        end
        save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)    
        notification = current_user.active_notifications.new(
            recipe_id: id,
            comment_id: comment_id,
            visited_id: visited_id,
            action: 'comment'
            )
            
        if notification.visitor_id == notification.visited_id
            notification.checked = true
        end
        notification.save if notification.valid?
    end
    
    #検索
    def self.looks(search, word)
       if search == "perfect_match"
         @recipe = Recipe.where("recipe_name LIKE?", "#{word}")
       elsif search == "forward_match"
         @recipe = Recipe.where("recipe_name LIKE?", "#{word}%")
       elsif  search == "backward_match"
         @recipe = Recipe.where("recipe_name LIKE?", "%#{word}")
       elsif search == "partial_match"
         @recipe = Recipe.where("recipe_name LIKE?", "%#{word}%")
       else
         @recipe = Recipe.all
       end
    end
    
end
