configure do
  enable :sessions
  set :session_expire_after, 2_592_000 # 30 days
end
