# SIGNUP

When /^I try to sign up$/ do
  click_link 'Signup'
end

When /^I submit valid user data$/ do
  fill_in 'Username', :with => @me.username
  fill_in 'Email', :with => @me.email
  click_button 'Submit'
end

When /^I submit invalid user data$/ do
  click_button 'Submit'
end

Then /^I should be redirected to the polls list$/ do
  selenium.wait_for_page_to_load
  selenium.location.should == "#{APP}/polls"
end

Then /^I should be shown validation errors$/ do
  response.should have_selector(".error")
end

Then /^I should be logged in$/ do
  response.should contain(h "Hello #{@me.username}!")
  response.should_not contain('Signup')
end

Then /^I should not be logged in$/ do
  response.should_not contain(h "Hello #{@me.username}!")  
  response.should contain('Signup')
end

# LOGIN

Given /^I have signed up$/ do
  @me.save!
end

When /^I try to login$/ do
  click_link 'Login'
end

When /^I submit valid credentials$/ do
  fill_in 'Username', :with => @me.username
  click_button 'Login'
end

When /^I submit fake credentials$/ do
  fill_in 'Username', :with => Sham.username
  click_button 'Login'
end

Given /^I am logged in$/ do
  When 'I go to the polls list'
  When 'I try to login'
  When 'I submit valid credentials'
end

When /^I try to logout$/ do
  click_link 'Logout'
end

# POLLS

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
  response.should contain('idbein beta invite')
end

Then /^my poll should not be in the polls list$/ do
  response.should_not have_selector('.poll')
end

# VOTING

Given /^a candidate previously created a poll$/ do
  new_poll(:title => 'poll', :threshold => 5).save!
end

Given /^I previously voted for the poll$/ do
  RestClient.put "#{APP}/polls/poll/votes/#{@me.id}", ''
end

When /^I vote for the poll$/ do
  click_link 'poll'
end

Then /^there should be a not\-voted icon$/ do
  response.should have_selector(".novote")
end

Then /^there should be a voted icon$/ do
  response.should have_selector(".voted")
end

Then /^the number of votes for it should be 1$/ do
  response.should have_xpath(".//div[@class = 'current-votes' and contains(text(), 1)]") 
end

Then /^the number of votes for it should be 0$/ do
  response.should have_xpath(".//div[@class = 'current-votes' and contains(text(), 0)]") 
end
