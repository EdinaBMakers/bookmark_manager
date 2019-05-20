feature 'Viewing bookmarks' do
  scenario 'index page displays title' do
    visit('/')

    expect(page).to have_content("Bookmark Manager")
  end

  scenario 'a user can view bookmarks' do
    visit('/bookmarks')

    expect(page).to have_content("https://makers.tech/")
    expect(page).to have_content("https://en-gb.facebook.com/")
    expect(page).to have_content("https://www.google.co.uk/")
  end
end
