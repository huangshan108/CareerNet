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
  def self.get_vis_data(class_name, params)
    response = []
    total = 0
    class_name.classify.constantize.all.each do |i|
      data = {}
      d = self.filter_by_query(i.students, params).map(&:salary).compact
      if d != []
        data[:class_name] = i.name
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

  def self.filter_by_query(students, params)
    students.select{ |s| self.filter_by_class_of(s.student, params[:class]) and self.filter_by_gender(s.student, params[:gender]) and self.filter_by_country(s.student, params[:country]) }
  end

  def self.filter_by_class_of(student, classes)
    if classes.include? student.class_of.to_s
      return true
    elsif classes == student.class_of.to_s
      return true
    else
      return false
    end
  end

  def self.filter_by_gender(student, genders)
    if genders.include? student.gender 
      return true 
    elsif genders == student.gender
      return true
    else
      return false
    end
  end
  
  def self.filter_by_country(student, countries)
    if countries.include? "intl" and student.country != "US"
      return true
    elsif countries.include? "US" and student.country == "US"
      return true
    else
      return false
    end
  end
end