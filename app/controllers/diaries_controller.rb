class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:show]

  def index
    @diary = Diary.new
    @user = current_user
    @diaries = Diary.where(user_id: current_user).order(start_time: "desc")
  end

  def show
    @diary = Diary.find(params[:id])
  end

  def create
    @diary = Diary.new(diaries_params)
    @diary.user_id = current_user.id
    @diary.start_time = Time.now
    @diaries = current_user.diaries

    if @diary.save
      flash[:notice] = "日記作成完了！"
      redirect_to diaries_path
    else
     render :index
    end

  end

  def destroy
    @diary = Diary.find(params[:id])
    if @diary.user_id == current_user.id
       @diary.delete
      redirect_to diaries_path
    end
  end

  def ensure_correct_user
    @diary = Diary.find(params[:id])
    unless @diary.user ==current_user
      redirect_to diaries_path
    end
  end

  private
  def diaries_params
    params.require(:diary).permit(:title, :text, :image)
  end
end
