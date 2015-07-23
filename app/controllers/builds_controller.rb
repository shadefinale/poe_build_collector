class BuildsController < ApplicationController
  def index
    @skills = builds_by_skill(params[:char].to_i)
  end


  private
    def builds_by_skill(char=nil)
      char = nil unless (1..7).include? char
      char.nil? ? Skill.includes(:builds).order(:name) : Skill.joins(:builds).includes(:builds).where('builds.char = ?', char.to_i).order("skills.name")
    end

end
