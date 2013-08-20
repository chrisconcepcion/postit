class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote, :destroy]
  before_action :require_user, only: [:edit, :create, :update, :new, :vote]
  before_action :require_creator, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

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
      if @post.update(post_params)
        @post.update_column(:updated_by, current_user.username) 
        redirect_to post_path(@post), notice: 'Post was successfully updated.' 
      else
        render :edit
      end
  end

  def destroy
    @post.destroy
    redirect_to posts_path

  end

  def vote
    if current_user.already_voted_on?(@post)
      respond_to do |format|
        format.html 
        format.js do
          render js: "alert('You can only vote on a post once!')"
        end
      end

    else
      

      Vote.create(voteable: @post, user_id: current_user.id, vote: params[:vote])
      respond_to do |format|
        format.html
        format.js
      end
    end
  end


private


  def post_params
    params.require(:post).permit!
  end

  def set_post
    @post = Post.find_by_slug(params[:id])
  end

  def require_creator
    access_denied unless logged_in? && ((current_user.id == @post.user_id) || current_user.admin?)
  end


end
