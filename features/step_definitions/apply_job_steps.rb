Given /the following companies exist/ do |companies_table|
  companies_table.hashes.each do |company|
    new_company = Company.create!({
      name: company[:name], 
      account_id: company[:account_id]
      })
  end
end
