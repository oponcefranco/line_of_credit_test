require 'spec_helper'

feature 'Scenario 2' do
  scenario 'line of credit for $1,000 and 35% APR' do
    visit '/'

    expect(page).to have_content('Listing')
  end
end