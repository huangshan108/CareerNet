Given /the following staffs exist/ do |staffs_table|
  staffs_table.hashes.each do |staff|
    new_staff = Staff.create!({
      first_name: staff[:first_name],
      last_name: staff[:last_name], 
      account_id: staff[:account_id]
      })
  end
end
