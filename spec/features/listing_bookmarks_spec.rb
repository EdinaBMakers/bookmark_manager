require 'pg'

feature 'Viewing bookmarks' do
  scenario 'index page displays title' do
    visit('/')

    expect(page).to have_content("Bookmark Manager")
  end

  scenario 'a user can view bookmarks' do
    Bookmark.create(url: 'https://makers.tech/', title: 'Makers')
    Bookmark.create(url: 'https://en-gb.facebook.com/', title: 'Facebook')
    Bookmark.create(url: 'https://www.google.co.uk/', title: 'Google')

    visit('/bookmarks')

    expect(page).to have_link("Makers", href: "https://makers.tech/")
    expect(page).to have_link("Facebook", href: "https://en-gb.facebook.com/")
    expect(page).to have_link("Google", href: "https://www.google.co.uk/")
  end
end
