class BuildsController < ApplicationController
  def index
    @builds = builds_by_skill
    if params[:char]
      @builds = builds_by_char(@builds, params[:char])
    end
  end


  private
    def builds_by_skill
      builds = []
      Skill.all.each do |skill|
        skill_list = {}
        skill_builds = []
        skill.builds.each do |build|
          skill_builds << build
        end
        skill_list[skill.name] = skill_builds
        builds << skill_list
      end
      builds.sort_by{|skill| skill.keys}
    end

    def builds_by_char(build_list, char)
      return build_list.each{|skill| skill.values.each{|builds| builds.select!{|build| build.char == char.to_i}}}
    end
end
