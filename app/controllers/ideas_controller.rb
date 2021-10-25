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
      redirect_to idea_path(@idea), notice: "Idea Created"
    else
      render :new
    end
  end

  def destroy
    @idea = Idea.find params[:id]
    @idea.destroy
    redirect_to ideas_path, notice: "Idea Deleted"
  end

  def edit
    @idea = Idea.find params[:id]
  end

  def update
    @idea = Idea.find params[:id]
    if @idea.update(params.require(:idea).permit(:title, :description))
      redirect_to idea_path(@idea), notice: "Idea Updated"
    else
      render :edit
    end
  end
end
