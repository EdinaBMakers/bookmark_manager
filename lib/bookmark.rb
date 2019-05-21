require 'pg'

class Bookmark
  def self.all
    connection = connect_to_db
    result = connection.exec "SELECT * FROM bookmarks"

    result.map { |bookmark| bookmark['url'] }
  end

  def self.add(url:)
    connection = connect_to_db
    connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
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
