require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require "./database_connection_setup"
require_relative "lib/space"
require_relative "lib/booking"
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

  get "/spaces/space/:id" do
    # temp bypass of user_id
    # session[:user_id] = 1

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

  get "/users/dashboard" do
    @booking = session[:current_booking]
    @space = Space.find_by_id(space_id: @booking.space_id)
    erb :"users/user_dashboard"
  end

  post "/spaces/space/:id/book" do
    space = Space.find_by_id(space_id: params[:id])
    # available = Booking.available?(space_id: params[:id], date_in: params[:date_in])

    if Booking.available?(space_id: params[:id], date_in: params[:date_in])
      session[:current_booking] = Booking.add(space_id: params[:id], date_in: params[:date_in], date_out: params[:date_out])
      redirect "/users/dashboard"
    else
      flash[:unavailable_alert] = "Sorry, this property is unavailable on #{params[:date_in]} :("
      redirect "/spaces/space/#{space.id}"
    end
  end

  def available?(space_id, date_in)
    Booking.available?(space_id: space_id, date_in: date_in)
  end

  run! if app_file == $0
end
