require 'descriptive_statistics'
module GeneralStats
=begin
    [
      name
      student_percentage
      stats = {
        :number=>11.0,
        :sum=>54,
        :variance=>7.7190082644628095,
        :standard_deviation=>2.778310325442932,
        :min=>1,
        :max=>9,
        :mean=>4.909090909090909,
        :mode=>2,
        :median=>5.0,
        :range=>8.0,
        :q1=>2.5,
        :q2=>5.0,
        :q3=>7.0
      }
    ]
=end
  def self.get_vis_data(class_name, countries, genders, classes)
    filtered = self.experience_by_student_filtered_query(countries, genders, classes)
    # byebug
    query_field = (class_name + "_id").downcase.to_sym
    grouped_data = filtered.group_by(&query_field)
    response = []
    total = 0
    grouped_data.each do |group_key, group|
      if group_key == nil
        next
      end
      data = {}
      d = group.map(&:salary).compact
      if d != []
        data[:class_name] = class_name.classify.constantize.find_by_id(group_key).name
        data[:stats] = d.descriptive_statistics
        total += data[:stats][:number]
        response << data
      end
    end
    response.each do |r|
      r[:student_percentage] = r[:stats][:number].fdiv(total)
    end
    return response
  end

  # Returns Activerecord::Relations of Experience filtered by 
  # Countries, genders and class of students owning them
  def self.experience_by_student_filtered_query(countries, genders, classes)
      result = Experience.none
      student_filtered = self.student_by_country_gender(countries, genders)
      classes.each do |class_of|
          student_filtered_by_year = student_filtered.where(:class_of => class_of.to_i)
          result = Experience.all.joins(:student).merge(student_filtered_by_year).union(result)
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
end