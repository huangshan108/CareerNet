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
        50.times do
            FactoryGirl.create(:student, graduation_date: "2017-5-15".to_date, major_id: 1)
        end
        
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
    end

    describe 'student_demographic_query(countries, genders, classes)' do
        it 'should return correctly students of interest' do
            result = Visualization.student_demographic_query(["US", "KR"], ["male", "other"], [2017, 2016])
            intl = result.where.not(country: "US").count
            f = result.where(gender: "female").count
            c = result.by_year(2017, field: :graduation_date).count
            expect(intl).to eq(0)
            expect(f).to eq(0)
            expect(c).to eq(50)
        end

        it 'should return the entire demograpic corretly' do
            result = Visualization.student_demographic_query(["US", "intl"], ["male", "other", "female"], [2017, 2016, 2015])
            expect(result.count).to eq(100)
          
        end

        it 'should return the international student data correctly' do
            result = Visualization.student_demographic_query(["intl"], ["male", "other", "female"], [2017, 2016, 2015])
            expect(result.count).to eq(50)
        end
    end

    describe 'json_by_category' do
        it 'should return correct json according to category' do
            result = Visualization.student_demographic_query(["US", "intl"], ["male", "other", "female"], [2017, 2016, 2015])
            json = Visualization.sub_json_by_category(result, "gender", ["male", "female", "other"])
            expect(json).to include({ name: "male", count: 50, percent: 50.0 })
            expect(json).to include({ name: "female", count: 50, percent: 50.0 })
            expect(json).to include({ name: "other", count: 0, percent: 0 })

        end
    end

    describe 'student_demographic_json' do
        it 'should return correct json for the query' do
            result = Visualization.student_demographic_json(["US"], ["male"], ["2017"])
            expect(result[:countries]).to include({name: "US", count: 50, percent: 100.0})
            expect(result[:genders]).to include({name: "male", count: 50, percent: 100.0})
            expect(result[:classes]).to include({name: "Class of 2017", count: 50, percent: 100.0})
            expect(result[:too_few]).to eq(false)
        end
    end

    # Compose json for one category e.g. gender
    # Sample output [{ name: "M", count: 3, percent: 30.0},
    #               {name: "F", count: 4, percent: 40.0},
    #               {name: "O", count: 3, percent: 30.0}]
    #def self.sub_json_by_category(query_result, category_name, categories)
    #    total = query_result.count
    #    others = total
    #    result = []
    #   categories.each do |category|
    #       if category_name == "class"
    #           count = query_result.by_year(category, field: :graduation_date).count
    #           # To display 'Class of <year>' rather than '<year>'
    #           category = "Class of " + category
    #       elsif category_name == "major"
    #           count = category[1]
    #           category = Major.find(category[0]).name
    #       else
    #           count = query_result.where(category_name => category).count
    #       end
    #       others -= count
    #       percentage = self.percentage_format(count, total)
    #       result += [{name: category, count: count, percent: percentage }]
    #   end

    #   # Account for others if query above don't add up too 100%
    #   if others != 0
    #       percentage = self.percentage_format(others, total)
    #       result += [{name: "Others", count: others, percent: percentage }]
    #   end
    #   result
    #end

    ## Computes percentage and formats it to 1 decimal place
    #def self.percentage_format(num, total)
    #    (num.to_f / total.to_f).round(3) * 100.0
    #end

    #def self.student_demographic_json(countries, genders, classes)
    #    # Find all students of interest
    #    query_result = self.student_demographic_query(countries, genders, classes)

    #    # Total num of students of interest
    #    all_count = query_result.count

    #    # Grab major_id's of majors which has 10% or more of students of interest
    #    # (So that the displace doesn't get too crowded)
    #    large_majors = query_result.group('major_id').having('COUNT(*) >= ?', all_count * 0.1).count.to_a


    #    # Student count by categories
    #    gender_count = sub_json_by_category(query_result, "gender", genders)
    #    country_count = sub_json_by_category(query_result, "country", countries)
    #    class_count = sub_json_by_category(query_result, "class", classes)
    #    major_count = sub_json_by_category(query_result, "major", large_majors)

    #    {
    #        countries: country_count,
    #        genders: gender_count,
    #        majors: major_count,
    #        classes: class_count
    #    }
    #end
end
