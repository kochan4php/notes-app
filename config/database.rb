require 'mysql2'

class Database
  protected

  def client
    Mysql2::Client.new(
      host: ENV['DB_HOST'],
      username: ENV['DB_USERNAME'],
      password: ENV['DB_PASSWORD'],
      database: ENV['DB_DATABASE']
    )
  end

  def query_stmt(statement)
    client.query(statement)
  end

  def prepare_stmt(statement)
    client.prepare(statement)
  end
end
