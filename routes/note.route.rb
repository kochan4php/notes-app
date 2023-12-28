get '/notes' do
  # redirect to '/login' unless session[:user_id]
  erb :"notes/index"
end

get '/notes/create' do
  # redirect to '/login' unless session[:user_id]
  erb :"notes/create"
end

post '/notes' do
  # redirect to '/login' unless session[:user_id]
end

get '/notes/:id/edit' do
  # redirect to '/login' unless session[:user_id]
  erb :"notes/edit"
end

put '/notes/:id' do
  # redirect to '/login' unless session[:user_id]
end

delete '/notes/:id' do
  # redirect to '/login' unless session[:user_id]
end
