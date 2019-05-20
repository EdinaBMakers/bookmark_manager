require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks).to eq([
        "https://makers.tech/",
        "https://en-gb.facebook.com/",
        "https://www.google.co.uk/"
        ])
    end
  end
end
