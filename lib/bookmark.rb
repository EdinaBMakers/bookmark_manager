require 'database_connection'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks")
    result.map { |bookmark_hash| to_bookmark(bookmark_hash) }
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title)" +\
    "VALUES('#{url}', '#{title}') RETURNING id, url, title").first

    to_bookmark(result)
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
    result.ntuples == 0 \
      ? nil \
      : to_bookmark(result.first)
  end

  def self.update(updated_bookmark:)
    DatabaseConnection.query("UPDATE bookmarks SET url = '#{updated_bookmark.url}', " +\
      "title = '#{updated_bookmark.title}' WHERE id = #{updated_bookmark.id}")
  end

  def eql?(other_bookmark)
    return false if other_bookmark == nil
    return false unless other_bookmark.is_a?(Bookmark)

    @id == other_bookmark.id \
    && @url == other_bookmark.url \
    && @title == other_bookmark.title
  end

  def ==(other_bookmark)
    eql?(other_bookmark)
  end

  def !=(other_bookmark)
    !(self == other_bookmark)
  end

  private

  def self.to_bookmark(bookmark_hash)
    Bookmark.new(id: bookmark_hash['id'], \
      url: bookmark_hash['url'], \
      title: bookmark_hash['title'])
  end
end
