class Public::CommentsController < ApplicationController
   before_action :authenticate_user!
   before_action :comment_edit_permission, only: [:edit, :update, :destroy]
    
    def create
        @comment = current_user.comments.new(comment_params)
        @recipe = @comment.recipe
        if @comment.save
            @recipe.create_notification_comment!(current_user, @comment.id)
            redirect_back(fallback_location: root_path)
        else
            redirect_back(fallback_location: root_path)
        end
    end
    
    def edit 
        @recipe = Recipe.find(params[:recipe_id])
        @comment = Comment.find(params[:id])
    end
    
    def update
        @recipe = Recipe.find(params[:recipe_id])
        @comment = Comment.find(params[:id])
        if @comment.update(comment_params)
            flash[:notice] = "コメントの内容を更新しました"
            redirect_to @recipe
        else
            flash[:error] = "更新できませんでした"
            render :edit
        end
    end
    
    def destroy
        @recipe = Recipe.find(params[:recipe_id])
        @comment = Comment.find_by(recipe_id: @recipe.id)
        if @comment.destroy
            flash[:error] = "コメントを削除しました"
            redirect_to recipe_path(params[:recipe_id])
        end
    end
    
    private 
    
    def comment_params
        params.require(:comment).permit(:content, :recipe_id).merge(recipe_id: params[:recipe_id])
    end
    
        
    def comment_edit_permission
        @recipe = Recipe.find(params[:recipe_id])
        @comment = Comment.find(params[:id])
        unless (@comment.user_id == current_user.id) || (@recipe.user_id == current_user.id)
            flash[:error] = "権限がありません"
            redirect_to recipes_path
        end
    end
    
    
end
