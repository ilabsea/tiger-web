class LayoutsController < ApplicationController
  before_action :authenticate_user!

  def index
    render "layouts/application"
  end
end
