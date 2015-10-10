class BuildsController < ApplicationController
  def index
    @builds = Build.includes(:skill).includes(:author)
  end
end
