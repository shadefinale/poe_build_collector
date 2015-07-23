class BuildsController < ApplicationController
  def index
    @skills, @builds = builds_by_skill(params[:char])
  end


  private
    def builds_by_skill(char=nil)
      skills = Skill.joins(:builds).group('skills.name')
      builds = {}
      if char
        skills.each{|skill| builds[skill] = Build.where(skill_id: skill.id, char: char)}
      else
        skills.each{|skill| builds[skill] = Build.where(skill_id: skill.id)}
      end
      return skills, builds
    end

end
