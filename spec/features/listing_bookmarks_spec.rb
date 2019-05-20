feature 'Viewing bookmarks' do
  scenario 'index page displays title' do
    visit('/')
    expect(page).to have_content "Bookmark Manager"
  end
end
