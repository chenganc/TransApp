class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :logged_in_user, only: [:show, :index, :edit, :update]

  before_action :correct_user,   only: [:show, :edit, :update]




  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    if current_user.admin?
    @users = User.paginate(page: params[:page])
    else
      redirect_to root_path
      flash[:error] = "Not authorized!"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome Back!"
      redirect_to home_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        # Handle a successful update.
        flash[:info] = "User was successfully updated."
        redirect_to edit_user_path
      else
        flash[:error] = "Update was unsuccessful."
        render 'edit'
      end
  end


  def feed
    Microposts.where("user_id = ?", id)
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      if !((@user == current_user) || (current_user.admin?))
        flash[:error] = "Not authorized!"
        redirect_to(root_path)
      end
    end



    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end
