class Public::CommentsController < ApplicationController
   
    def create
        @comment = current_user.comments.new(comment_params)
        @recipe = @rcomment.recipe
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
            flash[:success] = "コメントの内容を更新しました"
            redirect_to @recipe
        else
            flash[:danger] = "更新できませんでした"
            render :edit
        end
    end
    
    def destroy
        @recipe = Recipe.find(params[:recipe_id])
        @comment = Comment.find_by(recipe_id: @recipe.id)
        if @comment.destroy
            flash[:danger] = "コメントを削除しました"
            redirect_to recipe_path(params[:recipe_id])
        end
    end
    private 
    def comment_params
        params.require(:comment).permit(:content, :recipe_id).merge(recipe_id: params[:recipe_id])
    end
    
    
end
