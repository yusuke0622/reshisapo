class Recipe < ApplicationRecord
    belongs_to :user
    has_many :categories, dependent: :destroy
    has_many :recipe_tag_relatioons, dependent: :destroy
    has_many :tags, through: :recipe_tag_relations, dependent: :destroy
    
    has_one_attached :recipe_image
    
    def save_tag(sent_tags)
        current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
        old_tags = current_tags - sent_tags
        new_tags = sent_tags - currrent_tags
        
        old_tags.each do |old|
            self.tags.delete Tag.find_by(tag_name: old)
        end
        
        new_tags.each do |new|
            new_recipe_tag = Tag.find_or_create_by(tag_name: new)
            self_recipe_tags << new_recipe_tag
        end
        
    end
end
