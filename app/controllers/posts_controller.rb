class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, only: [:edit, :create, :update, :new, :vote]
  before_action :require_creator, only: [:edit, :update]

  def index
  	@post = Post.all
  end

  def show
    @comment = Comment.new 
  end

  def edit
  end

  def new
    @post = Post.new
  end

  def create

    @post = Post.new(post_params)
    @post.user_id = current_user.id
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

  def vote
    answer = true
    @post.votes.each do |votes|
      if votes.user_id == current_user.id
        answer = false
        break
      end
    end
    if answer == false
      redirect_to posts_path, notice: "You can only vote once per post."
    else
      Vote.create(voteable: @post, user_id: current_user.id, vote: params[:vote])
      redirect_to posts_path, notice: 'Vote was successful'
    end
  end

private


  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def require_creator
    access_denied unless logged_in? && current_user.id == @post.user_id
  end


end
