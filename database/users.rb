require_relative '../config/database'

class UsersSchema < Database
  def create
    sql_create = "
      CREATE TABLE IF NOT EXISTS users (
        id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        password VARCHAR(255) NOT NULL
      )
    "

    client.query(sql_create)
    client.close
  end

  def down
    client.query('DROP TABLE IF EXISTS users')
    client.close
  end
end
