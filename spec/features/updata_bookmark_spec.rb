feature 'Updating bookmark' do
  scenario 'user can update bookmark' do
    bookmark_to_update = Bookmark.create(url: 'https://makers.tech/', title: 'Makers')
    visit('/bookmarks')

    expect(page).to have_link("Makers", href: "https://makers.tech/")

    find_by_id("bookmark-#{bookmark_to_update.id}").click_button 'Edit'
    fill_in 'url', with: 'https://builders.tech/'
    fill_in 'title', with: 'Builders'
    click_button 'Update'

    expect(page).not_to have_link("Makers", href: "https://makers.tech/")
    expect(page).to have_link("Builders", href: "https://builders.tech/")
  end

  scenario 'bookmark cannot be found' do
    bookmark_to_update = Bookmark.create(url: 'https://makers.tech/', title: 'Makers')
    Bookmark.create(url: 'https://en-gb.facebook.com/', title: 'Facebook')
    visit('/bookmarks')

    expect(page).to have_link("Makers", href: "https://makers.tech/")
    Bookmark.delete(id: bookmark_to_update.id)
    find_by_id("bookmark-#{bookmark_to_update.id}").click_button 'Edit'

    expect(page).to have_content('Bookmark cannot be found')
    click_button 'Bookmarks'

    expect(page).to have_link("Facebook", href: "https://en-gb.facebook.com/")
  end
end
