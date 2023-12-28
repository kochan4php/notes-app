require_relative '../config/database'

class User < Database
  def get
    query_stmt('SELECT * FROM users')
  end

  def get_one(filter)
    stmt = prepare_stmt('SELECT * FROM users WHERE users.username = ? OR users.email = ? LIMIT 1')
    stmt.execute(filter[:username], filter[:email])
  end

  def create(params)
    stmt = prepare_stmt('INSERT INTO users (username, email, password) VALUES (?, ?, ?)')
    stmt.execute(params[:username], params[:email], params[:password])
  end

  def update(params)
    stmt = prepare_stmt('UPDATE users SET users.username = ?, users.email = ? WHERE users.id = ?')
    stmt.execute(params[:username], params[:email], params[:id])
  end

  def delete(params)
    stmt = prepare_stmt('DELETE FROM users WHERE users.id = ?')
    stmt.execute(params[:id])
  end
end
