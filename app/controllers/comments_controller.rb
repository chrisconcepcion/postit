class CommentsController < ApplicationController
	before_action :require_user, only: [:new, :create, :vote]
	  def new
	  	@comment = Comment.new
	  	@comment[:post_id] = post_id
	  end

	  def create
		@comment = Comment.new(comment_params)
		@comment.post_id = params[:post_id]
		@comment[:user_id] = current_user_id
	  	if @comment.save(comment_params)
	  		redirect_to post_path(@comment.post_id), notice: "Comment was posted successfully!"
	  	else
	  		render post_comments
	  	end
	  end

	  def vote
	   	@comment = Comment.find(params[:id])
    	if current_user.already_voted_on?(@comment)
      		redirect_to post_path(@comment.post_id), notice: "You can only vote once per comment."
    	else
      		Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])
      		redirect_to post_path(@comment.post_id), notice: 'Vote was successful'
    	end
  	   end

private

	  def comment_params
	  	params.require(:comment).permit(:comment)
	  end
end