require_relative '../feature_helper'

describe 'bacon search box' do
  it 'can find bacon degrees for actors with submit button', js: true do
    visit '/for_etsy'
    fill_in 'actor_search', with: "Kyra Sedgwick"
    click_button "Bacon Degrees"

    page.should have_content('Murder in the First')
  end

  it 'can find bacon degrees for actors with enter key', js: true do
    visit '/for_etsy'
    fill_in 'actor_search', with: "Toby Jones"
    page.execute_script("$('#actor_search').submit()")

    page.should have_content('Frost/Nixon')
  end
end