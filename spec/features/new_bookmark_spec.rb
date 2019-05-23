feature 'Adding bookmark' do
  scenario 'user can add bookmark via form' do
    visit('/bookmarks')
    fill_in 'url', with: 'https://www.bbc.co.uk/'
    fill_in 'title', with: 'BBC'
    click_button 'Add'

    expect(page).to have_link('BBC', href: 'https://www.bbc.co.uk/')
  end
end
