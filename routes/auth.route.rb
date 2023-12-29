require 'bcrypt'

require_relative '../models/user'
require_relative '../helper/session_msg.helper'

user = User.new

get '/login' do
  redirect to '/notes' if session[:user_id]

  success_message = session[:success_message]
  error_message = session[:error_message]

  @success_message = success_message[:text] if success_message && Time.now < success_message[:expire_after]
  @error_message = error_message[:text] if error_message && Time.now < error_message[:expire_after]

  erb :"auth/login"
end

get '/register' do
  redirect to '/notes' if session[:user_id]

  erb :"auth/register"
end

post '/register' do
  redirect to '/notes' if session[:user_id]

  username = params[:username]
  email = params[:email]
  password = BCrypt::Password.create(params[:password])

  user.create({ username: username, email: email, password: password })
  session[:success_message] = create_session_msg('Registered success, please login', 1)
  redirect to '/login'
end

post '/login' do
  redirect to '/notes' if session[:user_id]

  email = params[:email]
  password = params[:password]

  result = user.get_one({ email: email })

  result&.each do |row|
    if BCrypt::Password.new(row['password']) == password
      session[:user_id] = row['id']
      session[:email] = row['email']
      redirect to '/notes'
    else
      session[:error_message] = create_session_msg('Email or password is wrong', 1)
      redirect to '/login'
    end
  end
end

post '/logout' do
  session.clear
  redirect to '/login'
end
