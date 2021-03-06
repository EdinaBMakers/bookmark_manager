require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe '#new' do
    it 'creates a bookmark with id, url and title' do
      bookmark = Bookmark.new(id: 1, url: 'https://makers.tech/', title: 'Makers')

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
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.url).to eq('https://www.bbc.co.uk/')
      expect(bookmark.title).to eq('BBC')
    end
  end

  describe '.delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')
      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all).to be_empty
    end
  end

  describe '.find' do
    it 'returns bookmark when bookmark can be found with the given id' do
      bookmark = Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')

      expect(Bookmark.find(id: bookmark.id)).to eq(bookmark)
    end

    it 'returns nil when bookmark cannot be found with the given id' do
      expect(Bookmark.find(id: -1)).to eq(nil)
    end
  end

  describe '.update' do
    it 'updates the given bookmark' do
      bookmark = Bookmark.create(url: 'https://www.bbc.co.uk/', title: 'BBC')
      updated_bookmark = Bookmark.new(id: bookmark.id, url: 'https://makers.tech/', title: 'Makers')
      Bookmark.update(updated_bookmark: updated_bookmark)

      expect(Bookmark.find(id: bookmark.id)).to eq(updated_bookmark)
    end
  end
end
