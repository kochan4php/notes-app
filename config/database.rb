require 'mysql2'

class Database
  protected

  def client
    Mysql2::Client.new(host: 'localhost', username: 'root', password: '', database: 'db_runanotes')
  end

  def query_stmt(statement)
    client.query(statement)
  end

  def prepare_stmt(statement)
    client.prepare(statement)
  end
end
