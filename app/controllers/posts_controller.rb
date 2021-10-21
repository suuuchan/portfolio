class PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @post = current_user.post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_back(fallback_location: posts_path)
    else
      redirect_back(fallback_location: posts_path)
    end
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = current_user
    @comment= current_user.comments.new
    @comments=@post.comments
  end
  
  def destroy_all
    @post=current_user.posts
    @post.destroy_all
    redirect_to user_path(current_user)
  end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
