class RecipeTagRelation < ApplicationRecord
    belongs_to :tag
    belongs_to :recipe
end
