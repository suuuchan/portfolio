class CommentsController < ApplicationController

  def create
     @comment=current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path)
    else
      flash[:notice]="30文字をオーバーしています。"
      redirect_back(fallback_location: root_path)
    end

  end

  def destroy
    @comment=Comment.find(params[:id])
    if @comment.destroy
       redirect_to post_path(params[:post_id]), notice: 'コメントを削除しました'
    else
       flash.now[:alert] = 'コメント削除に失敗しました'
       render post_path(params[:post_id])
    end
  end


  private


  def comment_params
    params.require(:comment).permit(:title, :text, :image, :user_id, :post_id)
    # params.required(:comment).permit(:comment_text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
