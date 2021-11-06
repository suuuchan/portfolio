class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.all.page(params[:page]).per(6).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @user = @post.user
    @comment = current_user.comments.new
    @comments = @post.comments
  end

  def destroy_all
    @posts = current_user.posts
    @posts.destroy_all
    redirect_to user_path(current_user.id)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user = current_user
    @post.destroy
    flash[:notice] = "投稿を削除しました。"
    redirect_to posts_path
  end

  def search
    if params[:crop].present?
      user_list_ids = User.where("crop LIKE ?", "%#{params[:crop]}%").map(&:id)
      @posts = Post.where(user_id: user_list_ids)
    else
      @posts = []
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end

  def user_params
    params.require(:user).permit(:crop, :nickname)
  end
end
