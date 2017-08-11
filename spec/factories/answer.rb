FactoryGirl.define do
  factory :answer do
    factory :answer_1 do
      content 'Answer 1'
      correct true
    end

    factory :answer_2 do
      content 'Answer 2'
      correct false
    end

    factory :answer_3 do
      content 'Answer 3'
      correct false
    end

    factory :answer_4 do
      content 'Answer 4'
      correct false
    end

    factory :answer_5 do
      content 'Answer 5'
      correct false
    end
  end
end
