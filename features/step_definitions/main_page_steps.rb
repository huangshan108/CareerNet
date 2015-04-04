And /I click on the "(.*)" tab/ do
    steps %Q{ When I press "#{$1}" }
end

Then /I should be directed to "(.*)" page/ do
    page.should have_content($1)
end

I /should see my welcome message signaling that I logged in/ do
    page.should have_content("Welcome")
end
