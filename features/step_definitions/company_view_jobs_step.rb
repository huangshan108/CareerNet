Given /the following applications exist/ do |applications_table|
  applications_table.hashes.each do |application|
    new_application = Application.create!({
      student_id: application[:student_id], 
      job_id: application[:job_id]
    })
  end
end
