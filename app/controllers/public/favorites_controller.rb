class Public::FavoritesController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @recipe_favorite = Favorite.new(user_id: current_user.id, recipe_id: params[:recipe_id])
        @recipe_favorite.save
        @recipe = Recipe.find(params[:recipe_id])
        @recipe.create_notification_favorite!(current_user)
        redirect_to recipe_path(params[:recipe_id])
    end
    
    def destroy
        @recipe_favorite = Favorite.find_by(user_id: current_user.id, recipe_id: params[:recipe_id])
        @recipe_favorite.destroy
        redirect_to recipe_path(params[:recipe_id])
    end
    
end
