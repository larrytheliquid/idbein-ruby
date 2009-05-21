Given /^a candidate previously created a poll$/ do
  new_poll(:title => 'poll', :threshold => 5).save
end

When /^I vote for the poll$/ do
  RestClient.put "#{APP}/polls/poll/votes/#{current_user.id}", ''
end

Then /^the number of votes for it should be incremented$/ do
  response.body.strip_html.should contain('1/5')
end
