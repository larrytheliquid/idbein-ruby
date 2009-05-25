Given /^I am not logged in$/ do
  # noop
end

When /^I try to signup$/ do
  click_link 'Signup'
end

When /^I submit all required user fields$/ do
  fill_in 'Username', :with => 'larrytheliquid'
  fill_in 'Email', :with => 'larrytheliquid@gmail.com'
  click_button 'Submit'
end

Then /^I should be redirected to the polls list$/ do
  response.uri.request_uri.should == '/polls'
end

Then /^I should be logged in$/ do
  response.should contain(h 'Hello larrytheliquid!')
end
