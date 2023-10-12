class Public::RecipesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search_category, :search_tag]
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]
  
  def index
    @recipes = Recipe.page(params[:page]).order('id DESC').per(15)
  end
  
  def show
    @recipe = Recipe.find(params[:id])
    @recipe_tags = @recipe.tags
    @comments = @recipe.comments
    if user_signed_in?
      @comment = current_user.comments.new
    end
  end

  def new
    @recipe = Recipe.new
    @ingredients = @recipe.ingredients.build
    @steps = @recipe.steps.build
  end
  
  def create
    @recipe = current_user.recipes.new(recipe_params)
    tag_list = params[:recipe][:tag_ids].split(nil)
    if @recipe.save
      @recipe.save_tag(tag_list)
      flash[:notice] = "レシピが投稿されました"
      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end
  
  

  def edit
    @recipe = Recipe.find(params[:id])
    @tag_list = @recipe.tags.pluck(:tag_name).join(' ')
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    tag_list = params[:recipe][:tag_name].split(nil)
    if @recipe.update(recipe_params)
      @recipe.save_tag(tag_list)
      flash[:notice] = "投稿内容を変更しました"
      redirect_to recipe_path(@recipe.id)
    else 
      render :edit
    end
  end
  
  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:error] = "投稿を削除しました"
      redirect_to user_path(current_user)
    end
  end
  
  def search_tag
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @tag_recipes = @tag.recipes.page(params[:page]).order('id DESC').per(15)
  end
  
  def search_category
    @category = Category.find(params[:category_id])
    @category_recipes = @category.recipes.page(params[:page]).order('id DESC').per(15)
  end
  
  private
    
    def recipe_params
      params.require(:recipe).permit(:user_id, :recipe_name, :introduction, :serving, :category_id, :recipe_image, :step_image, tag_ids: [],
      ingredients_attributes:[:id, :ingredient_name, :quantity, :_destroy],
      steps_attributes:[:id, :explanation, :step_image, :number, :_destroy])
    end
    
    #他ユーザーからのアクセス制限
    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to recipes_path
      end
    end
    
end
