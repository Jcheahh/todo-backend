FactoryBot.define do
    factory :todo do
      task { Faker::Lorem.word }
      is_done { false }
    end
  end