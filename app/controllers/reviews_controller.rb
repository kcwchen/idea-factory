class ReviewsController < ApplicationController

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

  end
end
