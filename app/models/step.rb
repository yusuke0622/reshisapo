class Step < ApplicationRecord
    belongs_to :recipe
    has_one_attached :step_image
    
    validates :explanation, presence: true
    validates :number, presence: true
end
