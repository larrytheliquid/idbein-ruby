Given /^I am logged in$/ do
  new_user.save
end

When /^I go to the polls list$/ do
  visit "#{APP}/polls"
end

When /^I try to add a new poll$/ do
  click_link 'Add a Poll'
end

When /^I fill out and submit all required fields$/ do
  fill_in 'Title', :with => 'idbein beta invite'
  fill_in 'Description', :with => 'Want one? vote up while you have the chance!'
  fill_in 'Threshold', :with => '200'
  click_button 'Add Poll'
end

Then /^my poll should show up in the polls list$/ do
  response.should contain(CGI.escape 'idbein beta invite')
end
