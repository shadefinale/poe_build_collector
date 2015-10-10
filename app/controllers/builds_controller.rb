class BuildsController < ApplicationController
  def index
    @builds = Build.includes(:skill).includes(:author)
    respond_to do |format|
      format.json { render json: @builds.to_json(include: [:skill, :author]) }
    end
  end
end
