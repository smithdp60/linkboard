class PostsController < ApplicationController

  before_action :is_authenticated?

  def index
    @post = Post.new
    @posts = Post.all
    @vote = Vote.new

    respond_to do |format|
      format.json{ render json:@posts }
      format.html
    end
  end

  def new
    @post = Post.new
  end

  # create post (POST)
  def create
    @post = @current_user.posts.create(post_params)
    if @post.save
      flash[:success] = "Post Saved"
      redirect_to root_path
    else
      flash[:danger] = "Invalid Fields"
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.update(params[:id], post_params)
    if @post.update_attributes(post_params)
      flash[:success] = "Profile updated"
      redirect_to @post
    else
      flash[:danger] = "Invalid Fields"
      render 'edit'
    end
  end



  private

  def post_params
    params.require(:post).permit(:title, :link)
  end

end