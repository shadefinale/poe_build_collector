module SkillsHelper
  SKILLS = {[/(\W|^)animate guardian/] => "Animate Guardian",
  [/(\W|^)animate weapon/] => "Animate Weapon",
  [/(\W|^)arctic breath/] => "Arctic Breath",
  [/(\W|^)arc/] => "Arc",
  [/(\W|^)ball lightning/] => "Ball Lightning",
  [/(\W|^)barrage/] => "Barrage",
  [/(\W|^)bear trap/] => "Bear Trap",
  [/(\W|^)burning arrow/] => "Burning Arrow",
  [/(\W|^)cleave/] => "Cleave",
  [/(\W|^)cold snap/] => "Cold Snap",
  [/(\W|^)cyclone/] => "Cyclone",
  [/(\W|^)detonate dead/, /(^|\s+)dd(\W|$)/] => "Detonate Dead",
  [/(\W|^)discharge/] => "Discharge",
  [/(\W|^)dominat/] => "Dominating Blow",
  [/(\W|^)double strike/] => "Double Strike",
  [/(\W|^)dual strike/] => "Dual Strike",
  [/(\W|^)elemental hit/] => "Elemental Hit",
  [/(\W|^)ethereal knives/, /(^|\s+)ek(\W|$)/] => "Ethereal Knives",
  [/(\W|^)explosive arrow/, /(^|\s+)ea(\W|$)/] => "Explosive Arrow",
  [/(\W|^)fire nova mine/] => "Fire Nova Mine",
  [/(\W|^)fire trap/] => "Fire Trap",
  [/(\W|^)fireball/] => "Fireball",
  [/(\W|^)firestorm/] => "Firestorm",
  [/(\W|^)flame surge/] => "Flame Surge",
  [/(\W|^)flame totem/] => "Flame Totem",
  [/(\W|^)flameblast/] => "Flameblast",
  [/(\W|^)flicker/] => "Flicker Strike",
  [/(\W|^)freezing pulse/, /(^|\s+)fp(\W|$)/] => "Freezing Pulse",
  [/(\W|^)frenzy/] => "Frenzy",
  [/(\W|^)frost blades/] => "Frost Blades",
  [/(\W|^)frost wall/] => "Frost Wall",
  [/(\W|^)glacial cascade/, /(^|\s+)gc(\W|$)/] => "Glacial Cascade",
  [/(\W|^)glacial hammer/] => "Glacial Hammer",
  [/(\W|^)ground slam/] => "Ground Slam",
  [/(\W|^)heavy strike/] => "Heavy Strike",
  [/(\W|^)ice crash/] => "Ice Crash",
  [/(\W|^)ice nova/] => "Ice Nova",
  [/(\W|^)ice shot/] => "Ice Shot",
  [/(\W|^)ice spear/] => "Ice Spear",
  [/(\W|^)incinerate/] => "Incinerate",
  [/(\W|^)infernal blow/] => "Infernal Blow",
  [/(\W|^)kinetic blast/, /(^|\s+)kb(\W|$)/] => "Kinetic Blast",
  [/(\W|^)leap slam/] => "Leap Slam",
  [/(\W|^)lightning arrow/, /(^|\s+)la(\W|$)/] => "Lightning Arrow",
  [/(\W|^)lightning strike/] => "Lightning Strike",
  [/(\W|^)tendrils/] => "Lightning Tendrils",
  [/(\W|^)lightning trap/] => "Lightning Trap",
  [/(\W|^)magma orb/] => "Magma Orb",
  [/(\W|^)molten strike/] => "Molten Strike",
  [/(\W|^)poison arrow/, /(^|\s+)pa(\W|$)/] => "Poison Arrow",
  [/(\W|^)power siphon/] => "Power Siphon",
  [/(\W|^)puncture/] => "Puncture",
  [/(\W|^)spectre/, /zombie/, /summoner/] => "Summoner",
  [/(\W|^)reave/] => "Reave",
  [/(\W|^)searing bond/] => "Searing Bond",
  [/(\W|^)shock nova/] => "Shock Nova",
  [/(\W|^)shockwave/] => "Shockwave Totem",
  [/(\W|^)spark/] => "Spark",
  [/(\W|^)spectral throw/, /(^|\s+)st(\W|$)/] => "Spectral Throw",
  [/(\W|^)split arrow/, /(^|\s+)sa(\W|$)/] => "Split Arrow",
  [/(\W|^)static strike/, /(^|\s+)sa(\W|$)/] => "Static Strike",
  [/(\W|^)storm call/] => "Storm Call",
  [/(\W|^)raging spirits/, /(^|\s+)srs(\W|$)/] => "Summon Raging Spirits",
  [/(\W|^)sweep/] => "Sweep",
  [/(\W|^)tornado shot/, /(^|\s+)ts(\W|$)/] => "Tornado Shot",
  [/(\W|^)viper strike/, /(^|\s+)vs(\W|$)/] => "Viper Strike",
  [/(\W|^)wild strike/] => "Wild Strike"}

  def search_title_for_skill(title, build)
    SKILLS.each do |regex_arr, name|
      break if build.skill
      regex_arr.each do |regex|
        if title.downcase =~ regex
          build.skill = Skill.find_or_create_by(name: name)
          break
        end
      end
    end
  end

  def pull_builds(file_name, class_value)
    csv = CSV.read(file_name)
    csv.each do |line|
      build = Build.find_or_create_by(url: line[1])
      build.author = Author.find_or_create_by(name: line[2])
      build.title = line[0] unless build.title
      line[3].nil? ? (build.replies = 0) : (build.replies = line[3])
      line[4].nil? ? (build.posted_date = Time.now) : (build.posted_date = line[4])
      search_title_for_skill(build.title, build)
      build.char = class_value
      build.save
    end
  end

  def recategorize_builds(skill_name)
    builds = Build.where(skill: Skill.find_by_name(skill_name))
    builds.each do |build|
      SKILLS.each do |regex_arr, name|
        if build.title.downcase.match(Regexp.union(regex_arr))
          p name
          new_skill = Skill.find_or_create_by(name: name)
          build.update!(skill: new_skill)
          break
        end
        p build.skill.name
      end
    end
  end
end
