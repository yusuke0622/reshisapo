class Admin::RecipesController < ApplicationController
  def index
    @recipes = Recipe.page(params[:page]).order('id DESC').per(15)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
