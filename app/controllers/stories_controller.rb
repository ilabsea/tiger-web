class StoriesController < ApplicationController
  add_breadcrumb 'Stories', :users_path, only: [:new, :edit, :update, :create]
  before_action :authenticate_user!
  load_and_authorize_resource

  respond_to :json

  def index
    @stories = Story.all
    respond_with @stories.to_json(:include => :tags)
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)
    if @story.save
      render json: @story, status: :created, location: @story
    else
      render json: @story.errors, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def story_params
    params.require(:story).permit(:title, :description, :image, tags: [], tags_attributes: [:title])
  end

end
