FactoryBot.define do 
  factory :user do 
    username { Faker::Superhero.unique.name }
    password { "password" }
  end 
end