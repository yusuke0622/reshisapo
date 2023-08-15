class Admin::SearchesController < ApplicationController
    
    
    def search
        @range = params[:range]
        if @range == "User"
            @users = User.looks(params[:search], params[:word])
        else 
            @recipes = Recipe.looks(params[:search], params[:word])
        end
    end
    @category = Category.find_by(params[:id])
end
