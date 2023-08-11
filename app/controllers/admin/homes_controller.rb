class Admin::HomesController < ApplicationController
  def top
    @recipes = Recipe.page(params[:page]).order('id DESC').per(6)
    @categories = Category.all
  end
end
