if $PROGRAM_NAME == __FILE__
  require 'sinatra'
  require 'sinatra/contrib'
  require 'dotenv/load'

  # load app config
  require_relative 'config/app'

  # load routes app
  require_relative 'routes/index'

  # set template engine folder
  set :views, 'views'

  # set public folder
  set :public_folder, 'public'
end
