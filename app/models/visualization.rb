class Visualization < ActiveRecord::Base
    # Executes the query to select students we are interested in
    # Returns an ActiveRecord::Relation
    def self.student_demographic_query(countries, genders, classes)
        result = Student.none
        filtered = self.student_by_country_gender(countries, genders)
        classes.each do |class_of|
            result = filtered.by_year(class_of, field: :graduation_date).union(result)
        end
        result
    end


    # Handle specific case of filtering for countries
    def self.student_by_country_gender(countries, genders)
        if countries.include? "US" and countries.include? "intl"
            Student.where(gender:genders)
        elsif countries.include? "US"
            Student.where(country: countries, gender: genders)
        elsif countries.include? "intl"
            Student.where.not(country: "US").where(gender: genders)
        else
            Student.none
        end
    end

    # Compose json for one category e.g. gender
    # Sample output [{ name: "M", count: 3, percent: 30.0},
    #               {name: "F", count: 4, percent: 40.0},
    #               {name: "O", count: 3, percent: 30.0}]
    def self.sub_json_by_category(query_result, category_name, categories)
        if category_name == "country" and categories.include? "intl"
            categories = ["US"]
        end
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
        # (So that the display doesn't get too crowded)
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
            classes: class_count,
            too_few: all_count == 0
        }
    end

    # Returns json of average salary and count of all jobs in USA held by 
    # students that fit the category of 'countries, genders, classes'
    def self.salary_by_region_usa_json(countries, genders, classes)
        filtered = self.experience_by_student_filtered_query(countries, genders, classes)
        average = filtered.where(country: 'USA').group(:state).average(:salary)
        count = filtered.where(country: 'USA').group(:state).count

        result = []
        average.each do |key, value|
            if key != nil
                result += [{label: key, average: value.to_i, count: count[key]}]
            end
        end
        {
            usa_avg: result
        }
    end

    # Returns Activerecord::Relations of Experience filtered by 
    # Countries, genders and class of students owning them
    def self.experience_by_student_filtered_query(countries, genders, classes)
        result = Experience.none
        student_filtered = self.student_by_country_gender(countries, genders)
        classes.each do |class_of|
            student_filtered_by_year = student_filtered.by_year(class_of, field: :graduation_date)
            result = Experience.all.joins(:student).merge(student_filtered_by_year).union(result)
        end
        result
    end

end
