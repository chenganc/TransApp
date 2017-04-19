class BusStopsController < ApplicationController
  before_action :logged_in_user, only: [:create, :show, :new, :edit]

  def new
    @bus_stop = BusStop.new
  end

  def index
    @bus_stops = BusStop.order('stopNo ASC').page(params[:page])
  end

  def show
    @bus_stop = BusStop.find(params[:id])
    @microposts = @bus_stop.microposts.paginate(page: params[:page])
    @feed_items = feed.paginate(page: params[:page])
    @reviews = Review.where(bus_stop_id: @bus_stop.id).order("created_at DESC")
    @users = User.paginate(page: params[:page])

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  def create
    stopName = params[:stopName]
    stopNo = params[:stopNo]
    @bus_stop = BusStop.find_or_create_by(bus_stop_params)
    redirect_to bus_stop_path BusStop.find_or_create_by(bus_stop_params).id
  end

  def feed
    @microposts.where("bus_stop_id = ?", BusStop.find(@bus_stop.id))
  end

  private

  def bus_stop_params
    params.require(:bus_stop).permit(:stopName, :stopNo)
  end

  def logged_in_user
    if !logged_in?
      flash[:error] = "Please log in."
      redirect_to login_path
    end
  end
end
