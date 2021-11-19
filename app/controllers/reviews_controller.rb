class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @idea = Idea.find params[:idea_id]
    @review = Review.new params.require(:review).permit(:body)
    @review.idea = @idea
    @review.user = current_user
    if @review.save
      redirect_to idea_path(@idea), notice: "Review created"
    else
      @reviews = @idea.reviews.order(created_at: :desc)
      render 'ideas/show'
    end
  end

  def destroy
    @review = Review.find params[:id]
    if can?(:crud, @review)
      @review.destroy
      redirect_to idea_path(@review.idea), notice: "Review Deleted"
    else
      redirect_to root_path, alert: "Not Authorized"
    end
  end
end
