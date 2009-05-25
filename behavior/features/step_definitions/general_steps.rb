# SIGNUP

Given /^I am not logged in$/ do
  # noop
end

When /^I try to sign up$/ do
  click_link 'Signup'
end

When /^I submit valid user data$/ do
  fill_in 'Username', :with => 'larrytheliquid'
  fill_in 'Email', :with => 'larrytheliquid@gmail.com'
  click_button 'Submit'
end

When /^I submit invalid user data$/ do
  click_button 'Submit'
end

Then /^I should be redirected to the polls list$/ do
  response.uri.request_uri.should == '/polls'
end

Then /^I should be shown validation errors$/ do
  response.should have_selector(".error")
end

Then /^I should be logged in$/ do
  response.should contain(h 'Hello larrytheliquid!')
  response.should_not contain('Signup')
end

Then /^I should not be logged in$/ do
  response.should_not contain(h 'Hello larrytheliquid!')
  response.should contain('Signup')
end

# POLLS

Given /^I am logged in$/ do
  new_user.save
end

When /^I go to the polls list$/ do
  visit "#{APP}/polls"
end

When /^I try to add a new poll$/ do
  click_link 'Add a Poll'
end

When /^I submit valid poll data$/ do
  fill_in 'Title', :with => 'idbein beta invite'
  fill_in 'Description', :with => 'Want one? vote up while you have the chance!'
  fill_in 'Threshold', :with => '200'
  click_button 'Add Poll'
end

When /^I submit invalid poll data$/ do
  click_button 'Add Poll'
end

Then /^my poll should be in the polls list$/ do
  response.should have_selector('.poll')  
  response.should contain(CGI.escape 'idbein beta invite')
end

Then /^my poll should not be in the polls list$/ do
  response.should_not have_selector('.poll')
end

# VOTING

Given /^a candidate previously created a poll$/ do
  new_poll(:title => 'poll', :threshold => 5).save
end

Given /^I previously voted for the poll$/ do
  RestClient.put "#{APP}/polls/poll/votes/#{current_user.id}", ''
end

When /^I vote for the poll through the API$/ do
  RestClient.put "#{APP}/polls/poll/votes/#{current_user.id}", ''
end

Then /^the number of votes for it should be incremented$/ do
  response.body.strip_html.should contain('1/5')
end

Then /^the number of votes for it should not be incremented$/ do
  response.body.strip_html.should contain('1/5')
end
