class IdeasController < ApplicationController
  before_action :find_idea, only: [:show, :destroy, :edit, :update]
  before_action :authenticate_user!, except: [:index, :show]

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
    @idea.user = current_user
    if @idea.save
      redirect_to idea_path(@idea), notice: "Idea Created"
    else
      render :new
    end
  end

  def destroy
    if can?(:crud, @idea)
      @idea.destroy
      redirect_to ideas_path, notice: "Idea Deleted"
    else
      redirect_to root_path, alert: "Not Authorized"
    end
  end

  def edit
    if can?(:crud, @idea)
      render :edit
    else
      redirect_to idea_path, alert: "Not Authorized"
    end
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
