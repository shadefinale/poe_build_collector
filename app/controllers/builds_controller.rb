class BuildsController < ApplicationController
  def index
    if params[:char] && (1..7).include?(params[:char].to_i)
      @builds = Build.includes(:skill).where(char: params[:char].to_i)
    else
      @builds = Build.includes(:skill)
    end
    respond_to do |format|
      format.json { render json: @builds }
    end
  end
end
