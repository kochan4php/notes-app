require_relative '../config/database'

class Note < Database
  def get
    query_stmt('SELECT * FROM notes')
  end

  def get_by_id(id)
    stmt = prepare_stmt('SELECT * FROM notes WHERE notes.id = ? LIMIT 1')
    stmt.execute(id)
  end

  def get_by_id_with_user(id, user_id)
    stmt = prepare_stmt('SELECT * FROM notes WHERE notes.id = ? AND notes.user_id = ? LIMIT 1')
    stmt.execute(id, user_id)
  end

  def get_one(filter)
    stmt = prepare_stmt('SELECT * FROM notes WHERE notes.title = ? OR notes.body = ? LIMIT 1')
    stmt.execute(filter[:title], filter[:body])
  end

  def get_with_user(filter)
    stmt = prepare_stmt('SELECT * FROM notes WHERE notes.user_id = ?')
    stmt.execute(filter[:user_id])
  end

  def create(params)
    stmt = prepare_stmt('INSERT INTO notes (user_id, title, body) VALUES (?, ?, ?)')
    stmt.execute(params[:user_id], params[:title], params[:body])
  end

  def update(params)
    stmt = prepare_stmt('UPDATE notes SET notes.title = ?, notes.body = ? WHERE notes.id = ?')
    stmt.execute(params[:title], params[:body], params[:id])
  end

  def delete(params)
    stmt = prepare_stmt('DELETE FROM notes WHERE notes.id = ? AND notes.user_id = ?')
    stmt.execute(params[:id], params[:user_id])
  end
end
