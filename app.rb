require "sinatra/base"
require "sinatra/reloader"
require "sinatra/flash"
require_relative "./database_connection_setup"
require_relative "lib/space"
require_relative "lib/booking"
require_relative "lib/user"
require_relative "lib/request"
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
    @spaces_active = "active"
    @spaces = Space.show_all
    @user = get_session
    erb :spaces
  end

  get "/spaces/space/:id" do
    @user = get_session
    @space = Space.find_by_id(space_id: params[:id])
    erb :space_listing
  end

  get "/users/spaces" do
    @my_spaces_active = "active"
    @user = get_session
    if @user
      @user_spaces = Space.find_by_customer_id(customer_id: @user.id)
    end
    erb :"users/my_spaces"
  end

  get "/spaces/new" do
    @user = get_session
    erb :"spaces/new_space"
  end

  post "/spaces/add" do
    @user = get_session
    Space.add(customer_id: @user.id, name: params[:name], description: params[:description], city: params[:city], price: params[:price], hero_image: params[:hero_image])
    redirect "/spaces"
  end

  post "/spaces/space/:id/book" do
    @user = get_session
    space = Space.find_by_id(space_id: params[:id])

    if Booking.available?(space_id: params[:id], date_in: params[:date_in])
      session[:current_booking] = Booking.add(customer_id: @user.id, space_id: params[:id], date_in: params[:date_in], date_out: params[:date_out])
      redirect "/users/dashboard"
    else
      flash[:unavailable_alert] = "Sorry, this property is unavailable on #{params[:date_in]} :("
      redirect "/spaces/space/#{space.id}#unavailable"
    end
  end

  get "/users/register" do
    redirect('/users/login') if !logged_in?
    erb :"users/user_registration"
  end

  get "/users/login" do
    erb :"users/user_login"
  end

  post "/users/session" do
    if User.validate?(email: params[:email])
      session[:user] = User.authenticate(email: params[:email], password: params[:password])
      if session[:user].nil?
        flash[:notice] = "please check email and/or password"
        redirect("/users/login")
      else
        redirect("/spaces")
      end
    elsif !params[:email].empty? && !params[:password].empty?
      session[:user] = User.add(email: params[:email], password: params[:password])
      redirect("/spaces")
    else
      flash[:notice] = "Field cannot be empty, please try again"
      redirect("/users/register")
    end
  end

  get "/users/session/destroy" do
    session[:user] = nil
    redirect "/spaces"
  end


  get "/users/dashboard" do
    redirect('/users/login') if !logged_in?
    @user = get_session
    # @booking = Booking.last(customer_id: @user.id)
    # @received_decline = Booking.sort_bookings_by_request(booking_array: requests_received)

    @requests = Request.dashboard(customer_id: @user.id)
    @requests_received, @requests_made = Request.categorize(dashboard: @requests, current_user: @user.id)

    erb :"users/user_dashboard"
  end

  post '/users/dashboard/:booking_id/:action' do
    # booking_id = Booking.find_id(customer_id: , space_id: )
    # action(params[:action])
    p "params: #{params[:action]}"
    p "params booking: #{params[:booking_id]}"
    if params[:action] == "approve"
      Booking.approve!(booking_id: params[:booking_id].to_i)
    elsif params[:action] == "decline"
      Booking.decline!(booking_id: params[:booking_id].to_i)
    end

    redirect('/users/dashboard')
  end

  post '/users/dashboard/action/:approve' do
    Booking.approve(booking_id: params[:name])
    redirect('/users/dashboard')
  end

  post '/users/dashboard/action/decline' do

    redirect('/users/dashboard')
  end

  def action(button_name)
    # return unless action == "approve" || action == "decline"
    p button_name
    action_array = button_name.to_s.split("-")
    p action_array
    Booking.approve(action_array[1]) if "#{action_array[0]}" == "approve"
    Booking.decline(action_array[1]) if "#{action_array[0]}" == "decline"
  end

  def available?(space_id, date_in)
    Booking.available?(space_id: space_id, date_in: date_in)
  end

  def get_session
    session[:user] if logged_in?
  end

  def logged_in?
    !session[:user].nil?
  end

  run! if app_file == $0
end
