CONFIG = YAML.load_file(File.join(File.dirname(__FILE__), "../support/config/#{ENV_TYPE}.yml"))

# CLICK
When(/^click "([^"]*)"$/) do |selector|
  find(selector).click
end

When(/^click (\d+)\. "([^"]*)" button$/) do |index, button|
  click_button(button)[index.to_i]
end

When(/^click (SCENARIOS)$/) do |_tab|
  find(".category-list li:nth-of-type(2)").click
end

And(/^click "([^"]*)" link$/) do |link|
  click_link(link)
end

And(/^click "([^"]*)" button$/) do |button|
  click_button(button)
end

# FILL
When(/^fill Search with "([^"]*)"$/) do |arg|
  fill_in("Search...", with: arg)
end

When(/^fill "([^"]*)" with "([^"]*)"$/) do |input, content|
  fill_in(input, with: content)
end

And(/^fill "([^"]*)" with random$/) do |_arg|
  fill_in("Email", with: Array.new(5) { Array("a".."z").sample }.join + "@gmail.com")
end

And(/^fill product form with:$/) do |table|
  values = table.raw
  values.each do |raw|
    fill_in(raw[0], with: raw[1])
  end
end

# VERIFY
Then(/^verify "([^"]*)" text$/) do |content|
  page.should have_content(content)
end

Then(/^verify "([^"]*)" text at "([^"]*)"$/) do |content, selector|
  page.should have_selector(selector, text: content)
end

# UTIL
And(/^upload "([^"]*)" file$/) do |file|
  find('[name="file"]').send_keys(File.expand_path("../../../resource/#{file}", __dir__))
  page.should have_selector('[alt="Upload Preview"]')
end

Then(/^current url should include "([^"]*)"$/) do |path|
  URI.parse(current_url).request_uri.should include(path)
end

Given(/^visit homepage$/) do
  visit CONFIG["HOME"]
end

And(/^login with "([^"]*)" "([^"]*)"$/) do |email, pass|
  click_link("Sign In")
  fill_in("Email", with: email)
  fill_in("Password", with: pass)
  click_button("Sign In!")
  page.should have_content("SIGN OUT")
end

And(/^add (\d+)\. product to cart$/) do |arg|
  find(".Items__ItemsList-sc-180k6a5-1 > div:nth-of-type(1) button:nth-of-type(#{arg})").click
end

When(/^delete (\d+)\. product from cart$/) do |arg|
  page.all('[title="Delete Item"]')[arg.to_i - 1].click
end

And(/^accept alert$/) do
  page.accept_alert
end
