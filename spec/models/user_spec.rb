# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー新規登録' do
    let(:user) { FactoryBot.build(:user) }
    
    
    describe 'バリデーション' do
        context '新規登録がうまくいくとき' do
            it "内容に問題ない場合" do
                expect(user).to be_valid
            end
        end
        context '新規登録がうまくいかないとき' do
            it "ユーザーネームが空だと登録できない" do
                user.name = ""
                user.valid?
                expect(user.errors.full_messages).to include("ユーザーネームを入力してください")
            end
            it "メールアドレスが空では登録できない" do
                user.email = ""
                user.valid?
                expect(user.errors.full_messages).to include("メールアドレスを入力してください")
            end
            it "passwordが空では登録できない" do
                user.password = ""
                user.valid?
                expect(user.errors.full_messages).to include("パスワードを入力してください")
            end
            it "passwordが5文字以下であれば登録できない" do
                user.password = "00000"
                user.password_confirmation = "00000"
                user.valid?
                expect(user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
            end
            it "passwordが存在してもpassword_confirmationが空では登録できない" do
                user.password_confirmation = ""
                user.valid?
                expect(user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
            end
            it 'パスワードと確認用パスワードが間違っている場合、無効であること' do
                user.password = 'password'
                user.password_confirmation = 'pass'
                user.valid?
                expect(user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
            end
        end
    end
end
