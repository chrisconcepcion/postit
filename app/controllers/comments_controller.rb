class CommentsController < ApplicationController
	before_action :require_user, only: [:create, :vote]

	  def create
	  	
	  	@post = Post.find_by_slug(params[:post_id])
		@comment = Comment.new(comment_params)
		@comment.post_id = @post.id
		@comment[:user_id] = current_user_id
	  	if @comment.save(comment_params)
	  		redirect_to post_path(@post), notice: "Comment was posted successfully!"
	  	else
	  		render post_comments
	  	end
	  end

	  def vote
	  	@post = Post.find_by_slug(params[:post_id])
	   	@comment = Comment.find(params[:id])
    	if current_user.already_voted_on?(@comment)
      	respond_to do |format|
        	format.html 
      	 	format.js do
          		render js: "alert('You can only vote on a post once!')"
          	end
        end
    	else
      		Vote.create(voteable: @comment, user_id: current_user.id, vote: params[:vote])
      		respond_to do |format|
        		format.html
        		format.js
        	end
    	end
  	   end

private

	  def comment_params
	  	params.require(:comment).permit(:comment)
	  end
end