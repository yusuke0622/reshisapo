# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(
    email: 'admin@gmail.com',
    password: 'reshisapo0622'
    )
    
Tag.create!([
    { tag_name: '高血圧' },
    { tag_name: '糖質'}
    ])

Tag.create!([
    { tag_name: 'ネフローゼ症候群' },
    { tag_name: '腎臓病'}
    ])

    
Category.create!(
    category_name: '循環器系の疾患'
    )

Category.create!(
    category_name: '腎尿路生殖器系の疾患'
    )
#テストデータ
#ユーザー
takuma = User.find_or_create_by!(email: "takuma@example.com") do |user|
    user.name = "takuma"
    user.password = "password1"
    user.password_confirmation ="password1"
    user.user_icon = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user1.jpg"), filename:"sample-user1.jpg")
end

sasuke = User.find_or_create_by!(email: "sasuke@example.com") do |user|
    user.name = "sasuke"
    user.password = "password2"
    user.password_confirmation ="password2"
    user.user_icon = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user2.jpg"), filename:"sample-user2.jpg")
end

sakura = User.find_or_create_by!(email: "sakura@example.com") do |user|
    user.name = "sakura"
    user.password = "password3"
    user.password_confirmation ="password3"
    user.user_icon = ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-user3.jpg"), filename:"sample-user3.jpg")
end

