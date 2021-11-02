class PostsController < ApplicationController
  before_action :authenticate_user!
  # before_action :ensure_correct_user, only: [:destroy, :destroy_all]
  
  def new
    @post=Post.new
  end

  def create
    @post=current_user.posts.new(post_params)
    @post.user_id=current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts=Post.all
    @post=Post.page(params[:page]).per(12)
  end

  def show
    @post=Post.find(params[:id])
    @comments=@post.comments
    @user=@post.user
    @comment=current_user.comments.new
    @comments=@post.comments
  end

  def destroy_all
    @posts=current_user.posts
    # byebug
    @posts.destroy_all
    redirect_to user_path(current_user.id)
  end

  def destroy
    @post=Post.find(params[:id])
    @post.user=current_user
    @post.destroy
    flash[:notice]="投稿を削除しました。"
    redirect_to posts_path
  end

  # def ensure_correct_user
  #   @post = Post.find(params[:id])
  #   unless @Post.user == current_user
  #     redirect_to posts_path
  #   end
  # end

  private
  def post_params
    params.require(:post).permit(:title, :text, :image)
  end
end
