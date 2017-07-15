FactoryGirl.define do
  factory :support_request do
    subject "MyText"
    description "MyText"
    closed_at "2017-07-15 18:49:53"
    status "MyString"
    severity "MyString"
    category "MyString"
  end
end
