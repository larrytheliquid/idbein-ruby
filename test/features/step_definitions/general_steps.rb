# SIGNUP

When /^I try to sign up$/ do
  click_link 'Signup'
end

When /^I submit valid account info$/ do
  @me = new_user
  fill_in 'Username', :with => @me.username
  fill_in 'Email', :with => @me.email
  click_button 'Submit'
end

When /^I submit invalid account info$/ do
  click_button 'Submit'
end

Then /^I should be on the polls list$/ do
#   selenium.wait_for_page_to_load
#   selenium.location.should == "#{APP}/polls"
end

Then /^I should be shown validation errors$/ do
  response.should have_selector(".error")
end

Then /^I should be logged in$/ do
  greeting = h "Hello #{@me.username}!"
  response.should have_xpath(".//*[@id='greeting' and text()='#{greeting}']") 
  response.should_not contain('Signup')
end

Then /^I should not be logged in$/ do
  response.should_not have_selector('#greeting')
  response.should contain('Signup')
end

# LOGIN

Given /^I have signed up$/ do
  @me = new_user
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
  visit '/sessions/new'
  When 'I submit valid credentials'
end

When /^I try to logout$/ do
  click_link 'Logout'
end

# POLLS

When /^I go to the polls list$/ do
  visit "/polls"
end

When /^I try to add a new poll$/ do
  click_link 'Add a Poll'
end

When /^I submit valid poll data$/ do
  @my_poll = new_poll(:user_id => nil)
  fill_in 'Title', :with => h(@my_poll.title)
  fill_in 'Description', :with => h(@my_poll.description)
  fill_in 'Threshold', :with => @my_poll.threshold
  click_button 'Add Poll'
end

When /^I submit invalid poll data$/ do
  click_button 'Add Poll'
end

Then /^my poll should be in the polls list$/ do
  response.should have_selector('.poll')  
#   response.should contain(h @my_poll.description)
end

Then /^my poll should not be in the polls list$/ do
  response.should_not have_selector('.poll')
end

# VOTING

Given /^a candidate previously created a poll$/ do
  @poll = new_poll
  @poll.save!
end

Given /^I previously voted for the poll$/ do
#   RestClient.put "#{APP}/polls/#{@poll.id}/votes/#{@me.id}", ''
  put "/polls/#{@poll.id}/votes/#{@me.id}"
end

When /^I vote for the poll$/ do
  #   click_link "checkbox-#{@poll.id}"
  put "/polls/#{@poll.id}/votes/#{@me.id}"
end

Then /^there should be a not\-voted icon$/ do
  response.should have_selector(".novote")
end

Then /^there should be a voted icon$/ do
  response.should have_selector(".voted")
end

Then /^the number of votes for it should be 1$/ do
  response.should have_xpath(".//*[@class='current-votes' and text()='1']") 
end

Then /^the number of votes for it should be 0$/ do
  response.should have_xpath(".//*[@class='current-votes' and text()='0']") 
end

# MY POLLS

Given /^I previously created a poll$/ do
  @my_poll = new_poll(:user_id => @me.id)
  @my_poll.save!
end

When /^I try to view my polls$/ do
  click_link 'My Polls'
end

Then /^my poll should be listed$/ do
  response.should contain(h @my_poll.title)
end

Then /^another candidate\'s poll should not be listed$/ do
  response.should_not contain(h @poll.title)
end
