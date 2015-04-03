FactoryGirl.define do  factory :application do
    
  end

    factory :account do
        name "Quasimodo"
        email "humpback@notredame.edu"
        password "Esmeralda"
    end


    #factory :student do
    #    first_name "Moo"
    #    last_name "Quack"
    #    university "Mouth Wash University"
    #    #account_id
    #end

    #factory :major do
    #    name "Study of Toiletry"
    #    major_id nil
    #end

    #factory :college do
    #    address "1234 Toiletry Road"
    #    school_name "Collge of Toothpaste"
    #end

    #
    #factory :account_with_student do
    #    after(:create) do |account|
    #        create(:student, account: account)
    #    end
    #end

end
