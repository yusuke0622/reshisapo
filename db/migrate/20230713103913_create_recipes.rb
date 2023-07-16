class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :category_id, null: false
      t.string :recipe_name, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
