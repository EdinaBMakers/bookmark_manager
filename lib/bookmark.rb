require 'pg'

class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    connection = connect_to_db
    result = connection.exec "SELECT * FROM bookmarks"

    result.map do |bookmark_hash|
      Bookmark.new(bookmark_hash['id'], bookmark_hash['url'], bookmark_hash['title'])
    end
  end

  def self.create(url:, title:)
    connection = connect_to_db
    bookmark_hash = connection.exec("INSERT INTO bookmarks (url, title)" +\
    "VALUES('#{url}', '#{title}') RETURNING id, url, title").first

     Bookmark.new(bookmark_hash['id'], bookmark_hash['url'], bookmark_hash['title'])
  end

  def self.delete(id:)
    connection = connect_to_db
    connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  private

  def self.connect_to_db
    if ENV['ENVIRONMENT'] == 'test'
      PG.connect(:dbname => 'bookmark_manager_test')
    else
      PG.connect(:dbname => 'bookmark_manager')
    end
  end
end
