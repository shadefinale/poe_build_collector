class AuthorsController < ApplicationController
  def index
    @authors = Author.all.sort_by{|author| author.builds.length}.reverse
  end

  def show
    @author = Author.find(params[:id])
  end
end
