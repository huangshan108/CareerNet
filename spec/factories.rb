require 'faker'

FactoryGirl.define do  

  factory :experience do
    salary 1
    city "MyString"
    state "MyString"
    country "MyString"
    job_title "MyString"
    
  end
  factory :activity do
    
  end
  factory :project do
    
  end
  factory :workexperience do
    
  end
  factory :studentworkexperience do
    
  end
  factory :work_experience do
    
  end

  factory :visualization do
    
  end

  factory :industry do |f|
      f.name "Technology"
  end

  factory :company do |f|
    f.name Faker::Name.last_name
  end

  factory :staff do |f|
    f.first_name Faker::Name.first_name
    f.last_name Faker::Name.last_name
    f.description "I specialize in resume review."
  end

  factory :student do |f|
    f.first_name Faker::Name.first_name
    f.last_name Faker::Name.last_name
    f.graduation_date "2017-5-15".to_date
    f.country "US"
    f.gender "male"
  end

  factory :major do |f|
      f.name "Urban Forestry\r\n"
      f.id 90
  end

  factory :appointment do |f|
    f.time_slot 1
    f.day "2015-03-22"
    f.description "I want a resume review."
    f.note "Session notes by staff."

    f.association :staff, :factory => :staff
  end

  factory :interview do |f|
    f.time_slot 1
    f.day "2015-04-22"
    f.description "Interview"
    f.note "Extra notes"
    f.association :company, :factory => :company
  end

  factory :account do
      name "Quasimodo"
      email "humpback@notredame.edu"
      password "Esmeralda"
  end
end

