require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
# require "./database_connection_setup"
require "uri"


class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions, :method_override


  run! if app_file == $0
end
