class Recipe < ApplicationRecord
    belongs_to :Recipe
    belongs_to :category
    has_many :recipe_tag_relations, dependent: :destroy
    has_many :tags, through: :recipe_tag_relations, dependent: :destroy
    has_many :ingredients, dependent: :destroy
    accepts_nested_attributes_for :ingredients, reject_if: :all_blank, allow_destroy: true
    has_many :steps, dependent: :destroy
    accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true
    has_many :favorites, dependent: :destroy

    
    has_one_attached :recipe_image
    has_one_attached :step_image
    
    def favorited?(user)
        favorites.where(user_id: user.id).exists?
    end
    
    
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
