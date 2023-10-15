class Ingredient < ApplicationRecord
    
    belongs_to :recipe

    #材料・分量（バリデーション）
    validates :ingredient_name, presence: true, length: { maximum: 12 }
    validates :quantity, presence: true, length: { maximum: 10 }
    
end
