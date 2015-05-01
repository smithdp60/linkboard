class VotesController < ApplicationController

  before_action :is_authenticated?

  def index
    @vote = Vote.new
    @votes = Vote.where(user_id: @current_user)
  end

  # create post (POST)
  def create
    if params.key?(:user_id)
      thing = User.find_by_id(params[:user_id])
    elsif params.key?(:comment_id)
      thing = Comment.find_by_id(params[:comment_id])
    elsif params.key?(:post_id)
      thing = Post.find_by_id(params[:post_id])
    else
      return render plain: "invalid input."
    end

    my_vote = thing.votes.find_by_user_id(current_user.id)

    if my_vote.nil?
      current_user.ratings << thing.votes.create(vote_params)
    else
      if (params[:vote][:value].to_i != my_vote.value)
        my_vote.value = params[:vote][:value]
        my_vote.save
      else
        flash[:danger] = "You already done voted on that!"
      end
      # redirect_to posts_path
      respond_to do |format|
      #   format.json { render json:{ result: true, votes: thing.votes } }
      format.html  { redirect_to :back }
    end
  end
end

private
def vote_params
  params.require(:vote).permit(:value)
end

end