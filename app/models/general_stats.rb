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
  def self.get_vis_data(class_name)
    response = []
    total = 0
    class_name.classify.constantize.all.each do |i|
      data = {}
      d = i.students.select(:salary).map(&:salary).compact
      data[:class_name] = i.name
      data[:stats] = d.descriptive_statistics
      total += data[:stats][:number]
      response << data
    end
    response.each do |r|
      r[:student_percentage] = r[:stats][:number].fdiv(total)
    end
    return response
  end
end