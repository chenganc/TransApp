class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_bus_stop
  before_action :logged_in_user, only: [:create, :upvote, :downvote, :destroy, :edit, :update]

  def new
    @reviews = Review.where(bus_stop_id: @bus_stop.id).order("created_at DESC")
    if !@reviews.exists?(:user_id => current_user.id, :bus_stop_id => @bus_stop.id)
      @review = Review.new
    else
      redirect_to root_path
      flash[:error] = "You have already rated this stop"
    end
  end

  def edit
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.bus_stop_id = @bus_stop.id

    if @review.save
      redirect_to @bus_stop
    else
      render 'new'
    end
  end

  def update
    @review.update(review_params)
  end

  def destroy
    @review.destroy
    redirect_to root_path
  end

  private
    def set_review
      @review = Review.find(params[:id])
    end

    def set_bus_stop
      @bus_stop = BusStop.find(params[:bus_stop_id])
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
