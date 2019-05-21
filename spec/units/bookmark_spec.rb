require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES ('https://makers.tech/');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://en-gb.facebook.com/');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('https://www.google.co.uk/');")

      bookmarks = Bookmark.all

      expect(bookmarks).to eq([
        "https://makers.tech/",
        "https://en-gb.facebook.com/",
        "https://www.google.co.uk/"
        ])
    end
  end
end
