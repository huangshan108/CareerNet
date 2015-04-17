class Visualization < ActiveRecord::Base
    # Executes the query to select students we are interested in
    # Returns an ActiveRecord::Relation
    def self.student_demographic_query(countries, genders, classes)
        result = Student.none
        classes.each do |class_of|
            result = Student.where(country: countries, gender: genders).by_year(class_of).union(result)
        end
        result
    end

    # Compose json for one category e.g. gender
    # Sample output [{ name: "M", count: 3, percent: 30.0},
    #               {name: "F", count: 4, percent: 40.0},
    #               {name: "O", count: 3, percent: 30.0}]
    def self.sub_json_by_category(query_result, category_name, categories)
        total = query_result.count
        others = total
        result = []
       categories.each do |category|
           if category_name == "class"
               count = query_result.by_year(category, field: :graduation_date).count
               # To display 'Class of <year>' rather than '<year>'
               category = "Class of " + category
           elsif category_name == "major"
               count = category[1]
               category = Major.find(category[0]).name
           else
               count = query_result.where(category_name => category).count
           end
           others -= count
           percentage = self.percentage_format(count, total)
           result += [{name: category, count: count, percent: percentage }]
       end

       # Account for others if query above don't add up too 100%
       if others != 0
           percentage = self.percentage_format(others, total)
           result += [{name: "Others", count: others, percent: percentage }]
       end
       result
    end

    # Computes percentage and formats it to 1 decimal place
    def self.percentage_format(num, total)
        (num.to_f / total.to_f * 100.0).round(1)
    end

    def self.student_demographic_json(countries, genders, classes)
        countries ||= []
        genders ||= []
        classes ||= []
        # Find all students of interest
        query_result = self.student_demographic_query(countries, genders, classes)

        # Total num of students of interest
        all_count = query_result.count

        # Grab major_id's of majors which has 10% or more of students of interest
        # (So that the displace doesn't get too crowded)
        large_majors = query_result.group('major_id').having('COUNT(*) >= ?', all_count * 0.1).count.to_a


        # Student count by categories
        gender_count = sub_json_by_category(query_result, "gender", genders)
        country_count = sub_json_by_category(query_result, "country", countries)
        class_count = sub_json_by_category(query_result, "class", classes)
        major_count = sub_json_by_category(query_result, "major", large_majors)

        {
            countries: country_count,
            genders: gender_count,
            majors: major_count,
            classes: class_count
        }
    end
end