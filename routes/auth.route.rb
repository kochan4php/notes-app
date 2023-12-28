get '/login' do
  redirect to '/notes' if session[:user_id]
  erb :"auth/login"
end

get '/register' do
  redirect to '/notes' if session[:user_id]
  erb :"auth/register"
end

post '/login' do
end

post '/logout' do
end
