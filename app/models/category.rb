class Category < ApplicationRecord
    has_many :recipes, dependent: :destroy    
    
 def self.looks(search, word)
   if search == "perfect_match"
     @category = Category.where("name LIKE?", "#{word}")
   elsif search == "forward_match"
     @category = Category.where("name LIKE?", "#{word}%")
   elsif  search == "backward_match"
     @category = Category.where("name LIKE?", "%#{word}")
   elsif search == "partial_match"
     @category = Category.where("name LILE?", "%#{word}%")
   else
     @category = Category.all
   end
 end
end
