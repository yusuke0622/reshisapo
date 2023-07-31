class Admin::CommentsController < ApplicationController
  def destroy
    @recipe = Recipe.find(params[:recipe_id])
    @comment = user.comments.find_by(recipe_id: @recipe.id)
     if @comment.destroy
            flash[:danger] = "コメントを削除しました"
            redirect_to admin_recipe_path(params[:recipe_id])
     end
  end
end