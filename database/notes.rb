require_relative '../config/database'

class NotesSchema < Database
  def create
    sql_create = "
      CREATE TABLE IF NOT EXISTS notes (
        id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
        user_id INT(11) NOT NULL,
        title VARCHAR(255) NOT NULL,
        body TEXT
      )
    "

    sql_alter = 'ALTER TABLE notes ADD CONSTRAINT fk_user_note FOREIGN KEY (user_id) REFERENCES users(id)'

    client.query(sql_create)
    client.query(sql_alter)
    client.close
  end

  def down
    client.query('DROP TABLE IF EXISTS notes')
    client.close
  end
end
