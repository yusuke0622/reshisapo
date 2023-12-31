class RecipeTagRelation < ApplicationRecord
    belongs_to :tag
    belongs_to :recipe
    
    validates :recipe_id, presence: true
    validates :tag_id, presence: true
end
