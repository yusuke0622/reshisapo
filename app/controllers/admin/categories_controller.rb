class Admin::CategoriesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_category, only: [:edit, :update, :destroy]
  
  def index
    @category = Category.new
    @categories = Category.all
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "カテゴリーを追加しました"
      redirect_to admin_categories_path
    else
      @categoies = Category.all
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      flash[:notice] = "カテゴリー名を更新しました"
      redirect_to admin_categories_path
    else
      render 'edit'
    end
  end
  
  def destroy
    if @category.destroy
      flash[:error] = "カテゴリーを削除しました"
      redirect_to admin_categories_path
    end
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:category_name)
  end
end
