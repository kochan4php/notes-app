require 'bcrypt'

require_relative '../models/user'

user = User.new

get '/login' do
  redirect to '/notes' if session[:user_id]
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
  session[:success_message] = 'Registered success, please login'
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
      session[:error_message] = 'Wrong password'
      redirect to '/login'
    end
  end
end

post '/logout' do
  session.clear
  redirect to '/login'
end
