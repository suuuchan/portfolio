class CommentsController < ApplicationController
  def create
     @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_back(fallback_location: root_path) 
    else
      redirect_back(fallback_location: root_path) 
    end

  end

  def destroy
    Comment.find_by(id: params[:id]).destroy
  end

  def comment_params
    params.require(:comment).permit(:title, :text, :image, :user_id, :post_id)
  end
end
