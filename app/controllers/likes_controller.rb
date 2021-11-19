class LikesController < ApplicationController

  def create
    idea = Idea.find params[:idea_id]
    like = Like.new(idea: idea, user: current_user)
    if can?(:like, idea)
      if like.save
        flash[:notice] = "Idea Liked"
      else
        flash[:alert] = like.errors.full_messages.join(", ")
      end
    else 
      flash[:alert] = "You can't like your own idea"
    end
    redirect_to root_path
  end

  def destroy
    like = Like.find params[:id]
    if can?(:destroy, like)
      if like.destroy
        flash[:notice] = "Idea Unliked"
      else
        flash[:alert] = like.errors.full_messages.join(", ")
      end
    else 
      flash[:alert] = "You can't unlike an idea you didn't like"
    end
    redirect_to root_path
  end
end
