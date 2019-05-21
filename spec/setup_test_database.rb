require 'pg'

def setup_test_database
  p "Setting up test database before test..."

  connection = PG.connect(dbname: 'bookmark_manager_test')
  connection.exec("TRUNCATE bookmarks;")
end
