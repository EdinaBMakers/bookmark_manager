require 'pg'

feature 'Viewing bookmarks' do
  scenario 'index page displays title' do
    visit('/')

    expect(page).to have_content("Bookmark Manager")
  end

  scenario 'a user can view bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks VALUES (1, 'https://makers.tech/');")
    connection.exec("INSERT INTO bookmarks  VALUES(2, 'https://en-gb.facebook.com/');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'https://www.google.co.uk/');")

    visit('/bookmarks')

    expect(page).to have_content("https://makers.tech/")
    expect(page).to have_content("https://en-gb.facebook.com/")
    expect(page).to have_content("https://www.google.co.uk/")
  end
end
