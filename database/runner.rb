require_relative 'users'
require_relative 'notes'

users_schema = UsersSchema.new
notes_schema = NotesSchema.new

# drop table
notes_schema.down
users_schema.down

# create table
users_schema.create
notes_schema.create
