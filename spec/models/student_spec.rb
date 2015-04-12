require 'spec_helper'

describe Student do
    describe 'student_demographic_json' do
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
                FactoryGirl.create(:student, gender: "F",
                                   country: "KR", 
                                   graduation_date: "2016-5-15".to_date,
                                   major_id: 30)
            end

            # 30 students from China and are Female
            # Class of 2015
            # Urban Forestry major
            30.times do
                FactoryGirl.create(:student, gender: "F", 
                                   country: "CN", 
                                   graduation_date: "2015-5-15".to_date,
                                   major_id: 90)
            end
        end


        it 'should return simple correct json' do
            json = Student.student_demographic_json(["US", "CN", "KR"], ["F", "M"], [2015, 2016, 2017])
            major_count = [ { "Agricultural, general\r\n" => 50 },
                            { "Taxidermy/Taxidermist\r\n" => 20 },
                            { "Urban Forestry\r\n" => 30 }]
            class_count = [ { 2015 => 30 }, { 2016 => 20 }, { 2017 => 50 } ]
            correct_json = {
                percent_f: 0.5,
                percent_m: 0.5,
                percent_us: 0.5,
                majors: major_count,
                classes: class_count
            }
            expect(json).to eq(correct_json)
        end

        it 'should be supported by correct class_of count' do
            count_class_2017 = Student.class_of(2017).count
            expect(count_class_2017).to eq(50)
        end

        it 'should be supported by correct all_class_of count' do
            all = Student.all_class_of([2015, 2016, 2017]).count
            expect(all).to eq(100)
        end
    end

end
