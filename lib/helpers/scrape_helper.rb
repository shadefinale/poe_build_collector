require 'mechanize'
require 'date'

module ScrapeHelper
  class POEScraper
    @@class_pages = [
      'http://www.pathofexile.com/forum/view-forum/40',
      'http://www.pathofexile.com/forum/view-forum/marauder',
      'http://www.pathofexile.com/forum/view-forum/24',
      'http://www.pathofexile.com/forum/view-forum/436',
      'http://www.pathofexile.com/forum/view-forum/303',
      'http://www.pathofexile.com/forum/view-forum/41',
      'http://www.pathofexile.com/forum/view-forum/22'
      ]

    # If the thread contains one of these words we assume it is not a guide.
    @@banned_words = ["help", "question", "input", "someone", "?", "theorycraft", "1.3", "2.0", "discussion", "advice"]

    def initialize
      @agent = Mechanize.new

      # Important, please don't remove this and spam GGG with requests!
      @agent.history_added = Proc.new { sleep 1 }
    end

    def parse_forums
      @@class_pages.each_with_index do |class_url, index|
        parse_class(class_url, index)
      end
    end

    # Takes the class_url and appends all guides found to the proper csv.
    def parse_class(class_url, index)
      page = @agent.get(class_url)
      threads = get_threads(page)

      threads.each do |thread|
        info = generate_info(thread)
        build = Build.find_or_create_by(url: info[:link])
        build.title = info[:title]
        build.author = Author.find_or_create_by(name: info[:author])
        build.posted_date = info[:date]
        build.replies = info[:replies]
        search_title_for_skill(build.title, build)
        build.char = (index + 1)
        build.save
      end
    end

    # We input the page, get the thread elements.
    def get_threads(page)
      threads = page.search("#view_forum_table").search("tr")[1..-1]
      threads = get_relevant_threads(threads)
      threads = remove_irrelevant_threads(threads)
      threads
    end

    # already_scraped? just sees if our result is already written to our file.
    # We only want to append guides that we haven't already scraped.
    def already_scraped?(csv, link)
      return false if csv.empty?
      csv.any? {|entry| entry[1].include?(link)}
    end

    # We take the thread element and scrape the information we want from it.
    def generate_info(thread)
      info = {}
      info[:title] = thread.search(".title").text
      info[:link] = ("http://www.pathofexile.com" + thread.search("a")[0]["href"])[0..-6]
      info[:author] = thread.search(".postBy").search("a")[0].text
      info[:date] = Date.parse(thread.search(".postBy").search(".post_date").text)
      info[:replies] = thread.search(".replies").text.strip
      info
    end

    def get_relevant_threads(threads)
      threads.select {|thread| thread.search(".title").text.include? ("2.1")}
    end

    def remove_irrelevant_threads(threads)
      threads.reject{|thread| @@banned_words.any?{|word| thread.search(".title").text.downcase.include? (word)}}
    end
  end
end
