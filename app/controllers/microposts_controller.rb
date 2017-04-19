class MicropostsController < ApplicationController
	before_action :set_micropost, only: [:show, :edit, :update, :destroy]
	before_action :logged_in_user, only: [:create, :show,:upvote, :downvote, :destroy, :edit, :update]

	def index
		if current_user.admin?
			@microposts = Micropost.all.paginate(page: params[:page])
		else
			redirect_to root_path
			flash[:error] = "Not authorized!"
		end
	end


  def create
	    @micropost = current_user.microposts.build(micropost_params)
	    if @micropost.save
	      flash[:success] = "Micropost created!"
	      #redirect_to root_url
				redirect_to :back
	    else
	      @feed_items = []
	      render 'static_pages/home'
	    end

  end

	def show
		@bus_stop = BusStop.find(params[:id])

	end

	def edit
		@micropost = Micropost.find(params[:id])
	end

	def update
		respond_to do |format|
			if @micropost.update(micropost_params)
				format.html { redirect_to micropost_path(@micropost), notice: 'Post was successfully updated.' }
				format.json { render :show, status: :ok, location: @micropost }
			else
				format.html { render :edit }
				format.json { render json: @micropost.errors, status: :unprocessable_entity }
			end
		end
	end

  def upvote
  		@micropost = Micropost.find(params[:id])

  		if @micropost.save
  			@micropost.upvote_by current_user
  			flash[:success] = "Upvoted"
  		else
  			flash[:error] = "Please Sign In"
  		end
  		redirect_to :back
  	end

  	def downvote
  		@micropost = Micropost.find(params[:id])

  		if @micropost.save
  			@micropost.downvote_by current_user
  			flash[:success] = "Downvoted"
  		else
  			flash[:error] = "Please Sign In"
  		end
  		redirect_to :back
  	end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to :back
  end

  private

		def set_micropost
			@micropost = Micropost.find(params[:id])
		end

    def micropost_params
      params.require(:micropost).permit(:bus_stop_id,:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
			if !((@user == current_user) || (current_user.admin?))
      	redirect_to root_url
			end
    end

    def authorized_user
      @micropost = current_user.links.find_by(id: params[:id])
      redirect_to microposts_path, notice: "Not authorized to edit this micropost" if @micropost.nil?
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
			flash[:error] = "Not authorized!"
    end

		def logged_in_user
			if !logged_in?
				flash[:error] = "Please log in."
				redirect_to login_path
			end
		end

end
