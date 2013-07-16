class CommentsController < ActionController::Base
	  def new
	  	@comment = Comment.new
	  	@comment[:post_id] = post_id
	  end

	  def create
		@comment = Comment.new(comment_params)
		@comment.post_id = params[:post_id]
	  	if @comment.save(comment_params)
	  		redirect_to posts_path, notice: "Comment was posted successfully!"
	  	else
	  		render post_comments
	  	end
	  end

	  def comment_params
	  	params.require(:comment).permit(:comment)
	  end
end