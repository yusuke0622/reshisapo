class Public::SearchesController < ApplicationController
    
    def search
        @range = params[:range]
        
        if @range == "User"
            @users = User.looks(params[:search], params[:word])
        elsif @range == "Recipe"
            @recipes = Recipe.looks(params[:search], params[:word])
        elsif @range == "Category"
            @categories = Category.looks(params[:search], params[:word])
        else
            @tags = Tag.looks(params[:search], params[:word])
        end
    end
end
