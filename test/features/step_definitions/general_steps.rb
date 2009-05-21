Given /^I am logged in$/ do
  new_user.save
end

When /^I go to the polls list$/ do
  visit "#{APP}/polls"
end
