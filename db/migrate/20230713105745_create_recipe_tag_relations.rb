class CreateRecipeTagRelations < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_tag_relations do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false
      t.timestamps
    end
  end
end
