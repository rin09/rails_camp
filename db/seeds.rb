User.create(email: 'hoge@example.com', password: '12345678', password_confirmation: '12345678')

Article.create!(
             content: "hey",
             title: "hello",
             user_id: 1)

50.times do |n|
  Article.create!(
               content: Faker::Lorem.sentence(5),
               title: Faker::Lorem.sentence(5),
               user_id: 1)
end

