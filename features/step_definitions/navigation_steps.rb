Given(/^I am on the "(.+)" page$/) do |page_path|
	visit page_path
end

Given(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I press "(.*?)"$/) do |field|
  click_button field
end

Then /^show me the page$/ do
  save_and_open_screenshot
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

