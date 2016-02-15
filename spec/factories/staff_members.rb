FactoryGirl.define do
  factory :staff_member do
    sequence(:email){ |n| "member#{n}@example.com" }
    family_name  "山田#{n}"
    given_name  "太郎"
    family_name_kana 'ヤマダ'
    given_name_kana 'タロウ'
    password 'pw'
    start_date { Date.yesterdasy }
    end_date nil
    suspended false
  end

end
