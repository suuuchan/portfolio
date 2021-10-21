class DiariesController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy, :destroy_all]

  def index
    @diary = Diary.new
    @user = current_user
    @diaries = Diary.where(user_id: current_user).order(start_time: "desc")
  end

  def create
    @user = current_user
    @diary = Diary.new(diaries_params)
    @diary.user_id = current_user.id
    @diary.start_time = Time.now
    @diaries = current_user.diaries
    p @diary.user_id,current_user.id,@diary.user_id == current_user.id
    # if @diary.user_id == current_user.id
    @diary.save
    flash[:notice] = "日記作成完了！"
    redirect_to diaries_path
    # else
    #   render :index
    # end
  end

  def ensure_correct_user
    @diary = Diary.find(params[:id])
    unless @diary.user == current_user
      redirect_to diaries_path
    end
  end

  def diaries_params
    params.require(:diary).permit(:title, :text, :image)
  end
end
