class Public::HomesController < ApplicationController
  def top
    @recipes = Recipe.page(params[:page]).order('id DESC').per(6)
    @tag_list = Tag.all
    @categories = Category.all
  end
  
  def category_detail
  end
end
