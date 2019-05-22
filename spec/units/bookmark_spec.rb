require 'bookmark'

describe Bookmark do
  describe '#new' do
    it 'creates a bookmark with id, url and title' do
      bookmark = Bookmark.new(1, 'https://makers.tech/', 'Makers')

      expect(bookmark.id).to eq(1)
      expect(bookmark.url).to eq('https://makers.tech/')
      expect(bookmark.title).to eq('Makers')
    end
  end

  describe '.all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.create(url: 'https://makers.tech/', title: 'Makers')
      Bookmark.create(url: 'https://en-gb.facebook.com/', title: 'Facebook')
      Bookmark.create(url: 'https://www.google.co.uk/', title: 'Google')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq(3)
      expect(bookmarks.first).to be_a(Bookmark)
      expect(bookmarks.first.id).to eq(bookmark.id)
      expect(bookmarks.first.title).to eq('Makers')
      expect(bookmarks.first.url).to eq('https://makers.tech/')
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')

      expect(bookmark.url).to eq('https://www.bbc.co.uk/')
      expect(bookmark.title).to eq('BBC')
    end
  end
end
