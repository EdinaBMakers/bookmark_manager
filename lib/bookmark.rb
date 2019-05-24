require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id:, url:, title:)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    connection = connect_to_db
    result = connection.exec("SELECT * FROM bookmarks")

    result.map { |bookmark_hash| to_bookmark(bookmark_hash) }
  end

  def self.create(url:, title:)
    connection = connect_to_db
    bookmark_hash = connection.exec("INSERT INTO bookmarks (url, title)" +\
    "VALUES('#{url}', '#{title}') RETURNING id, url, title").first

    to_bookmark(bookmark_hash)
  end

  def self.delete(id:)
    connection = connect_to_db
    connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.find(id:)
    connection = connect_to_db
    result = connection.exec("SELECT * FROM bookmarks WHERE id = #{id}")
    result.ntuples == 0 \
      ? nil \
      : to_bookmark(result.first)
  end

  def self.update(updated_bookmark:)
    connection = connect_to_db
    connection.exec("UPDATE bookmarks SET url = '#{updated_bookmark.url}', " +\
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

  def self.connect_to_db
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(:dbname => 'bookmark_manager_test')
    else
      PG.connect(:dbname => 'bookmark_manager')
    end
  end

  def self.to_bookmark(bookmark_hash)
    Bookmark.new(id: bookmark_hash['id'], \
      url: bookmark_hash['url'], \
      title: bookmark_hash['title'])
  end
end
