class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
   
  def top
    @recipes = Recipe.page(params[:page]).order('id DESC').per(6)
    @categories = Category.all
    @tags = Tag.find(RecipeTagRelation.group(:tag_id).order('count(recipe_id) desc').limit(12).pluck(:tag_id))
  end
end
