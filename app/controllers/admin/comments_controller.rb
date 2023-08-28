class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = Comment.find_by(recipe_id: @recipe.id)
     if @comment.destroy
            flash[:danger] = "コメントを削除しました"
            redirect_to admin_recipe_path(params[:recipe_id])
     end
  end
end
