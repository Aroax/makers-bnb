require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./database_connection_setup"
require_relative "lib/space"
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

  get "/" do
    redirect("/spaces")
  end

  get "/spaces" do
    @spaces = Space.show_all
    erb :spaces
  end

  # post "/spaces/:id" do
  #   space_id = params[:id]
  #   p params[:id]
  #   @space = Space.find_by_id(space_id: space_id)
  #   erb :space_listing
  # end

  get "/spaces/space/:id" do
    "params #{params[:id]}"
    space_id = params[:id]
    @space = Space.find_by_id(space_id: params[:id])
    erb :space_listing
  end

  get "/spaces/new" do
    erb :"spaces/new_space"
  end

  post "/spaces/add" do
    Space.add(name: params[:name], description: params[:description], city: params[:city], price: params[:price], hero_image: params[:hero_image])
    redirect "/spaces"
  end

  run! if app_file == $0
end
