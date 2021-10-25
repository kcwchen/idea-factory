class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :destroy, :edit, :update]

  def index
    @ideas = Idea.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea Created"
    else
      render :new
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_path, notice: "Idea Deleted"
  end

  def edit
  end

  def update
    if @idea.update(idea_params)
      redirect_to idea_path(@idea), notice: "Idea Updated"
    else
      render :edit
    end
  end

  private

  def find_idea
    @idea = Idea.find params[:id]
  end

  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
