class PostsController < ApplicationController

  before_action :is_authenticated?

  def index
    @post = Post.new
    @posts = Post.where(user_id: @current_user)
  end

  def new
    @post = Post.new
  end

  # create post (POST)
  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "Post Saved"
      redirect_to root_path
    else
      flash[:danger] = "Invalid Fields"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :link)
  end

end