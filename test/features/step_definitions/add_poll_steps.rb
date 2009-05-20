Given /^I am logged in$/ do
  # TODO: implement login 
end

When /^I fill out and submit all required fields$/ do
  post '/polls', {:poll => poll_attributes(:title => 'Find me')}
  @redirect = last_response
  follow_redirect!
end

Then /^I should get redirected to the polls list$/ do
  @redirect.status.should == 302
  @redirect.headers['location'].should == '/polls'
end

Then /^my poll should show up in the polls list$/ do
  last_response.should contain('Find me')
end
