class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:create, :upvote, :downvote, :destroy, :edit, :update]


  def index
    if current_user.admin?
      @comments = Comment.all.paginate(page: params[:page])
    else
      redirect_to root_path
      flash[:error] = "Not authorized!"
    end
  end


  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.new(comment_params)
    @comment.user = current_user

      if @comment.save
        flash[:info] = "Comment was successfully created."
        redirect_to :back

      else
        flash[:error] = "Operation was unsuccessful."
        redirect_to :back
      end

  end


  def destroy
    @comment.destroy
    flash[:info] = "Comment deleted"
    redirect_to :back
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(comment_params)
      flash[:info] = "Comment was successfully updated"
      redirect_to micropost_path(@comment.micropost.id)

    else
      flash[:error] = "Comment could not be updated"
      redirect_to micropost_path(@comment.micropost.id)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :micropost_id)
    end

end
