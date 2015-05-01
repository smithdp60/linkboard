class CommentsController < ApplicationController

  before_action :is_authenticated?

  def index
    @comment = Comment.new
    @post = Post.find_by_id(params[:post_id])
    @comments = @post.comments
    @vote = Vote.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    current_user.comments << @comment
    redirect_to post_comments_path(@post)
  end

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

end
