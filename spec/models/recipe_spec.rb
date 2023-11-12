# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
    describe 'ユーザーログイン' do
        before do
            @user = FactoryBot.create(:user)
        end
        context 'ログインし、マイページに遷移' do
            it 'ログインにする' do
                sign_in @user
                expect(current_path).to eq user_path(@user)
            end
            it 'レシピ投稿ボタンが表示される'do
                expect(page).to have_button 'レシピ投稿'
                click_button 'レシピ投稿'
            end
            it 'レシピ新規投稿画面に遷移' do
                expect(current_path).to eq new_recipe_path
            end
        end
        context '表示の確認' do
            it '投稿ボタンが表示されているか' do
                expect(page).to have_button '投稿'
            end
        end
    end
    
    describe '投稿画面のテスト' do
        before do
            visit new_recipe_path
        end
        context '投稿処理のテスト' do
            it '投稿後のリダイレクト先は正しいか' do
                fill_in 'recipe[recipe_name]', with: Faker::Lorem.characters(number:10)
                fill_in 'recipe[introduction]', with: Faker::Lorem.characters(number:20)
                fill_in 'recipe[category_id]', with: Faker::Number.between(to: 1)
                fill_in 'recipe[serving]', with: Faker::Number.between(to: 3)
                fill_in 'recipe_with_tag[tag_name]', with: Faker::Lorem.characters(number:4)
                fill_in 'recipe_with_ingredient[ingredient_name]', with: Faker::Lorem.characters(number:5)
                fill_in 'recipe_with_ingredient[quantity]', with: Faker::Lorem.characters(number:5)
                fill_in 'recipe_with_step[explanation]', with: Faker::Lorem.characters(number:10)
                click_button '投稿'
                expect(page).to have_current_path recipe_path(Recipe.last)
            end
        end
    end
    
    describe "レシピ投稿一覧のテスト" do
        before do
            visit recipes_path
        end
        context '表示の確認' do
            it '投稿されたものが表示されているか' do
                expect(page).to have_content recipe.recipe_name
                expect(page).to have_link recipe.recipe_name
            end
        end
    end
    
    describe "レシピ詳細画面のテスト" do
        before do
            visit recipe_path(recipe)
        end
        context '表示の確認' do
            it '投稿されたものが表示されているか' do
                expect(page).to have_content recipe.recipe_name
                expect(page).to have_content recipe.introduction
                expect(page).to have_content recipe.category
                expect(page).to have_content recipe.serving
                expect(page).to have_content recipe_with_tag.tag_name
                expect(page).to have_content recipe_with_ingredient.ingredient_name
                expect(page).to have_content recipe_with_ingredient.quantity
                expect(page).to have_content recipe_with_step.explanation
            end
            it '編集ボタンが存在しているか' do
                expect(page).to have_button '編集'
            end
            it '削除ボタンが存在しているか' do
                expect(page).to have_button '削除'
            end
        end
        context 'ボタン(リンク)の遷移先の確認' do
            it '編集の遷移先は編集画面か' do
                edit_link = find_all('a')[3]
                edit_link.click
                expect(current_path).to eq('/recipes/' + recipe.id.to_s + '/edit')
            end
        end
        context 'レシピ削除のテスト' do
            it 'レシピ削除' do
                expect{ recipe.destroy }.to change{ Recipe.count }.by(-1)
            end
        end
    end
    
    describe '編集画面のテスト' do
        before do
            visit edit_recipe_path(recipe)
        end
        context '表示の確認' do
            it '編集前の投稿内容がフォームに表示されている' do
                expect(page).to have_field 'recipe[recipe_name]', with: recipe.recipe_name
                expect(page).to have_field 'recipe[introduction]', with: recipe.introduction
                expect(page).to have_field 'recipe[category]', with: recipe.category
                expect(page).to have_field 'recipe[serving]', with: recipe.serving
                expect(page).to have_field 'recipe_with_tag[tag_name]', with: recipe_with_tag.tag_name
                expect(page).to have_field 'recipe_with_ingredient[ingredient_name]', with: recipe_with_ingredient.ingredient_name
                expect(page).to have_field 'recipe_with_ingredient[quantity]', with: recipe_with_ingredient.quantity
                expect(page).to have_field 'recipe_with_step[explanation]', with: recipe_with_step.explanation
            end
            it '更新ボタンが存在する' do
                expect(page).to have_button '更新'
            end
        end
        context '更新処理に関するテスト' do
            it '更新後のリダイレクト先は正しいか' do
                fill_in 'recipe[recipe_name]', with: Faker::Lorem.characters(number:10)
                fill_in 'recipe[introduction]', with: Faker::Lorem.characters(number:20)
                fill_in 'recipe[category_id]', with: Faker::Number.between(to: 1)
                fill_in 'recipe[serving]', with: Faker::Number.between(to: 3)
                fill_in 'recipe_with_tag[tag_name]', with: Faker::Lorem.characters(number:4)
                fill_in 'recipe_with_ingredient[ingredient_name]', with: Faker::Lorem.characters(number:5)
                fill_in 'recipe_with_ingredient[quantity]', with: Faker::Lorem.characters(number:5)
                fill_in 'recipe_with_step[explanation]', with: Faker::Lorem.characters(number:10)
                @recipe.recipe_image = fixture_file_upload("spec/fixtures/images/test_image.jpg")
                click_button '更新'
                expect(page).to have_current_path recipe_path(recipe)
            end
            it '新たに投稿した画像が表示されているか' do
                expect(page).to have_selector(@recipe.recipe_image)
            end
        end
    end
end
