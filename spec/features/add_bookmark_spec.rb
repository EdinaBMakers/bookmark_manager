feature 'Adding bookmark' do
  scenario 'add bookmark via form' do
    visit('/bookmarks')
    fill_in 'url', with: 'https://www.bbc.co.uk/'
    click_button 'Add'

    expect(page).to have_content('https://www.bbc.co.uk/')
  end
end
