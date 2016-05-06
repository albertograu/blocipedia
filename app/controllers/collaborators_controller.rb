class CollaboratorsController < ApplicationController

  before_action :set_wiki

  def index
    @users = User.all
  end

  def create
    @collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if @collaborator.save
      flash[:notice] = "Your collaborator was added"
    else
      flash[:alert] = "Whoops! There was an error, please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Your collaborator was removed"
    else
      flash[:alert] = "Whoops! There was an error, please try again."
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  private
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
