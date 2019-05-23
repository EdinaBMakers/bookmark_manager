feature 'Deleting bookmark' do
  scenario 'user can delete boomark' do
    Bookmark.create(url: 'https://makers.tech/', title: 'Makers')
    bookmark_to_delete = Bookmark.create(url: 'https://en-gb.facebook.com/', title: 'Facebook')
    Bookmark.create(url: 'https://www.google.co.uk/', title: 'Google')
    visit('/bookmarks')

    expect(page).to have_link("Makers", href: "https://makers.tech/")
    expect(page).to have_link("Facebook", href: "https://en-gb.facebook.com/")
    expect(page).to have_link("Google", href: "https://www.google.co.uk/")

    find_by_id("bookmark-#{bookmark_to_delete.id}").click_button 'Delete'

    expect(page).to have_link("Makers", href: "https://makers.tech/")
    expect(page).not_to have_link("Facebook", href: "https://en-gb.facebook.com/")
    expect(page).to have_link("Google", href: "https://www.google.co.uk/")
  end
end
