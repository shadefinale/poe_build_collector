class BuildsController < ApplicationController
  def index
    @skills = builds_by_skill(params[:char])
  end


  private
    def builds_by_skill(char=nil)
      char.nil? ? Skill.includes(:builds).order("skills.name") : Skill.joins(:builds).includes(:builds).where('builds.char = ?', char.to_i).order("skills.name")
    end

end
