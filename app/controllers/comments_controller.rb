class CommentsController < ApplicationController
	before_action :require_user, only: [:new, :create]
	  def new
	  	@comment = Comment.new
	  	@comment[:post_id] = post_id
	  end

	  def create
		@comment = Comment.new(comment_params)
		@comment.post_id = params[:post_id]
		@comment[:user_id] = current_user_id
	  	if @comment.save(comment_params)
	  		redirect_to posts_path, notice: "Comment was posted successfully!"
	  	else
	  		render post_comments
	  	end
	  end

private

	  def comment_params
	  	params.require(:comment).permit(:comment)
	  end
end