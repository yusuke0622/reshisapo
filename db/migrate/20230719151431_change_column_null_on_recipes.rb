class ChangeColumnNullOnRecipes < ActiveRecord::Migration[6.1]
  def change
    change_column_null :recipes, :serving, false
    change_column_null :recipes, :user_id, false
  end
end
