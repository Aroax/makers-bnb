require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./database_connection_setup"
require "uri"
require_relative './lib/space.rb'

class MakersBnb < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::Flash
  enable :sessions, :method_override

  get "/test" do
    "Hello JAMI"
  end

  get "/space" do
    @spaces = Space.all
    erb :"spaces/space"
  end

  run! if app_file == $0
end
