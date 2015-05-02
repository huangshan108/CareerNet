require 'spec_helper'

describe Visualization do
    before :each do
        # 3 Majors
        FactoryGirl.create(:major)
        FactoryGirl.create(:major, name: "Taxidermy/Taxidermist\r\n", id: 30)
        FactoryGirl.create(:major, name: "Agricultural, general\r\n", id: 1)

        # 50 Students from US and are Male
        # Class of 2017
        # Agricultural, general major
        48.times do
            FactoryGirl.create(:student, graduation_date: "2017-5-15".to_date, major_id: 1)
        end
        # These two students has experiences
        @student1 = FactoryGirl.create(:student, graduation_date: "2017-5-15".to_date, major_id: 1)
        @student2 = FactoryGirl.create(:student, graduation_date: "2017-5-15".to_date, major_id: 1)
        
        # 20 students from Korea and are Female
        # Class of 2016
        # Taxidermy/Taxidermist major
        20.times do
            FactoryGirl.create(:student, gender: "female",
                               country: "KR", 
                               graduation_date: "2016-5-15".to_date,
                               major_id: 30)
        end

        # 30 students from China and are Female
        # Class of 2015
        # Urban Forestry major
        30.times do
            FactoryGirl.create(:student, gender: "female", 
                               country: "CN", 
                               graduation_date: "2015-5-15".to_date,
                               major_id: 90)
        end

        @exp1 = FactoryGirl.create(:experience, student: @student1)
        @exp2 = FactoryGirl.create(:experience, student: @student2)
    end

    # describe 'student_demographic_query(countries, genders, classes)' do
    #     it 'should return correctly students of interest' do
    #         result = Visualization.student_demographic_query(["US", "KR"], ["male", "other"], [2017, 2016])
    #         intl = result.where.not(country: "US").count
    #         f = result.where(gender: "female").count
    #         c = result.by_year(2017, field: :graduation_date).count
    #         expect(intl).to eq(0)
    #         expect(f).to eq(0)
    #         expect(c).to eq(50)
    #     end

    #     it 'should return the entire demograpic corretly' do
    #         result = Visualization.student_demographic_query(["US", "intl"], ["male", "other", "female"], [2017, 2016, 2015])
    #         expect(result.count).to eq(100)
          
    #     end

    #     it 'should return the international student data correctly' do
    #         result = Visualization.student_demographic_query(["intl"], ["male", "other", "female"], [2017, 2016, 2015])
    #         expect(result.count).to eq(50)
    #     end
    # end

    # describe 'json_by_category' do
    #     it 'should return correct json according to category' do
    #         result = Visualization.student_demographic_query(["US", "intl"], ["male", "other", "female"], [2017, 2016, 2015])
    #         json = Visualization.sub_json_by_category(result, "gender", ["male", "female", "other"])
    #         expect(json).to include({ name: "male", count: 50, percent: 50.0 })
    #         expect(json).to include({ name: "female", count: 50, percent: 50.0 })
    #         expect(json).to include({ name: "other", count: 0, percent: 0 })

    #     end
    # end

    # describe 'student_demographic_json' do
    #     it 'should return correct json for the query' do
    #         result = Visualization.student_demographic_json(["US"], ["male"], ["2017"])
    #         expect(result[:countries]).to include({name: "US", count: 50, percent: 100.0})
    #         expect(result[:genders]).to include({name: "male", count: 50, percent: 100.0})
    #         expect(result[:classes]).to include({name: "Class of 2017", count: 50, percent: 100.0})
    #         expect(result[:too_few]).to eq(false)
    #     end
    # end

    # describe 'experience_by_student_filtered_query' do
    #     it 'should return correct instances of Experience Activerecord:relation' do
    #         result = Visualization.experience_by_student_filtered_query(["US"], ["male"], ["2017"])
    #         expect(result).to include(@exp1)
    #         expect(result).to include(@exp2)
    #     end
    # end

end
