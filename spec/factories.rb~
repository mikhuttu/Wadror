FactoryGirl.define do
  
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
    admin false
    active true
  end

  factory :style do
    name "Euro Pale Ale"
    description "Hyvää olutta"
  end

  factory :brewery do
    name "anonymous"
    year 1900
    active true
  end

  factory :beer do
    name "anonymous"
    brewery
    style
  end

  factory :rating do
    score 10
  end

end
