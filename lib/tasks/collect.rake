require 'csv'
require './lib/helpers/skills_helper.rb'
require './lib/helpers/scrape_helper.rb'
include SkillsHelper
include ScrapeHelper

namespace :collect do

  task :pull_csv => :environment do
    class_hash = {"duelist" => 1, "marauder" => 2, "ranger" => 3, "scion" => 4,
                  "shadow" => 5, "templar" => 6, "witch" => 7}

    class_hash.each do |class_name, class_value|
      file_name = "./lib/builds/%s.csv" % class_name
      if File.exist?(file_name)
        pull_builds(file_name, class_value)
      end
    end
  end

  task :pull_forums => :environment do
    s = POEScraper.new
    s.parse_forums
  end

  task :fix_skill_names, [:skill] => :environment do |task, args|
    recategorize_builds(args.skill)
  end
end
