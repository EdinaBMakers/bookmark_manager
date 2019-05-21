require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      Bookmark.add(url: 'https://makers.tech/')
      Bookmark.add(url: 'https://en-gb.facebook.com/')
      Bookmark.add(url: 'https://www.google.co.uk/')

      bookmarks = Bookmark.all

      expect(bookmarks).to eq([
        "https://makers.tech/",
        "https://en-gb.facebook.com/",
        "https://www.google.co.uk/"
        ])
    end
  end

  describe '.add' do
    it 'adds a new bookmark to bookmarks' do
      Bookmark.add(url: 'https://www.bbc.co.uk/')

      expect(Bookmark.all).to include('https://www.bbc.co.uk/')
    end
  end
end
