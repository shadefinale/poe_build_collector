class BuildsController < ApplicationController
  def index
    if params[:char] && (1..7).include?(params[:char].to_i)
      @builds = Build.includes(:skill).includes(:author).where(char: params[:char].to_i)
    else
      @builds = Build.includes(:skill).includes(:author)
    end
    respond_to do |format|
      format.json { render json: @builds.to_json(include: [:skill, :author]) }
    end
  end
end
