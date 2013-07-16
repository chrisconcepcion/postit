class PostsController < ApplicationController

  def index
  	@post = Post.all
  end

  def show
  	@post = Post.find(params[:id])
    @comment = Comment.new 
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save(post_params)
        redirect_to @post, notice: 'Post was successfully updated.' 
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])
      if @post.update(post_params)
        redirect_to @post, notice: 'Post was successfully updated.' 
      else
        render :edit
      end
    
  end

  def post_params
    params.require(:post).permit(:title, :url, :description)
  end


end
