class AuthorsController < ApplicationController
  def index
    @authors = Author.joins(:builds).group("builds.author_id").order("count(builds.author_id) desc")
  end

  def show
    @author = Author.find(params[:id])
  end
end
