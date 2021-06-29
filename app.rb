require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./database_connection_setup"
require "uri"


class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions, :method_override

  get "/test" do
    "Hello JAMI"
  end

  get '/' do
    redirect('/spaces')
  end

  get '/spaces' do
    erb(:spaces)
  end

  get '/spaces/new' do
    erb :new_space
  end

  run! if app_file == $0
end
