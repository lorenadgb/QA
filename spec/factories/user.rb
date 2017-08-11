FactoryGirl.define do
  factory :admin do
    email                  'admin@example.com'
    password               'password'
    password_confirmation  'password'
    admin                  true
  end

  factory :visitor do
    email                  'visitor@example.com'
    password               'password'
    password_confirmation  'password'
    admin                  false
  end
end
