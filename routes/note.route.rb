require_relative '../models/note'
require_relative '../helper/session_msg.helper'

note = Note.new

get '/notes' do
  redirect to '/login' unless session[:user_id]

  success_message = session[:success_message]
  error_message = session[:error_message]

  @success_message = success_message[:text] if success_message && Time.now < success_message[:expire_after]
  @error_message = error_message[:text] if error_message && Time.now < error_message[:expire_after]

  @notes = note.get_with_user({ user_id: session[:user_id] })
  erb :"notes/index"
end

get '/notes/create' do
  redirect to '/login' unless session[:user_id]

  erb :"notes/create"
end

post '/notes' do
  redirect to '/login' unless session[:user_id]

  title = params[:title]
  body = params[:body]

  note.create({ user_id: session[:user_id], title: title, body: body })
  session[:success_message] = create_session_msg('Note created successfully', 1)
  redirect to '/notes'
end

get '/notes/:id/edit' do
  redirect to '/login' unless session[:user_id]

  @note = note.get_by_id_with_user(params[:id], session[:user_id]).first
  erb :"notes/edit"
end

put '/notes/:id' do
  redirect to '/login' unless session[:user_id]

  title = params[:title]
  body = params[:body]
  id = params[:id]

  note.update({ id: id, title: title, body: body })
  session[:success_message] = create_session_msg('Note updated successfully', 1)
  redirect to '/notes'
end

delete '/notes/:id' do
  redirect to '/login' unless session[:user_id]

  note.delete({ id: params[:id], user_id: session[:user_id] })
  session[:success_message] = create_session_msg('Note deleted successfully', 1)
  redirect to '/notes'
end
