require 'csv'
namespace :collect do
  task :pull_csv => :environment do
    csv = CSV.read("./lib/builds/duelist.csv")
    csv.each do |line|
      if Build.where(url: line[1]).first
        new_build = Build.find_by(url: line[1])
        new_build.views = line[3] unless line[3].nil?
        new_build.date = line[4] unless line[4].nil?
      else
        new_build = Build.new
        new_build.author = Author.new(name: line[2])
        new_build.title = line[0]
        new_build.url = line[1]
        new_build.char = 1
        new_build.views = line[3] unless line[3].nil?
        new_build.date = line[4] unless line[4].nil?
      end

      new_build.save
    end
  end
end
