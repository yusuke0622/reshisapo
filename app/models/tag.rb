class Tag < ApplicationRecord
    has_many :recipe_tag_relations, dependent: :destroy
    has_many :recipes, through: :recipe_tag_relations, dependent: :destroy
    
 def self.looks(search, word)
   if search == "perfect_match"
     @tag = Tag.where("name LIKE?", "#{word}")
   elsif search == "forward_match"
     @tag = Tag.where("name LIKE?", "#{word}%")
   elsif  search == "backward_match"
     @tag = Tag.where("name LIKE?", "%#{word}")
   elsif search == "partial_match"
     @tag = Tag.where("name LILE?", "%#{word}%")
   else
     @tag = Tag.all
   end
 end
end
