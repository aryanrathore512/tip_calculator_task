FactoryBot.define do
  factory :calculation do
    bill_amount { 100.0 }
    tip_percentage { 10.0 }
    number_of_people { 2 }
    tip_amount { 20.0 }
    total_bill { 120.0 }
    per_person_amount { 60.0 }
  end
end
