FactoryGirl.define do
  factory :question do
    factory :question_1 do
      content 'Question 1'
      source  'google.com.br'
      year    Date.current.year

      association :user, factory: :admin
    end

    factory :question_2 do
      content 'Question 2'
      source  'wikipedia.com'
      year    Date.current.last_year.year

      association :user, factory: :admin
    end
  end
end
