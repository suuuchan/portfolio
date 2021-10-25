class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :unsubscribe]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    # byebug
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
       render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "編集内容、きちんと保存できました！"
    else
      render :edit
    end
  end

  def unsubscribe
    @user=current_user
  end

  def ensure_correct_user
    @user=User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(@user.id)
    end
  end


  private
  def user_params
    params.require(:user).permit(:nickname, :username, :introduction, :image, :crop)
  end
end
