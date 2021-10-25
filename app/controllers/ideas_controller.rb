class IdeasController < ApplicationController

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def show
    @idea = Idea.find params[:id]
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(params.require(:idea).permit(:title, :description))
    if @idea.save
      redirect_to idea_path(@idea)
    else
      render :new
    end
  end

  def destroy
    @idea = Idea.find params[:id]
    @idea.destroy
    redirect_to ideas_path
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update 

  end
end
