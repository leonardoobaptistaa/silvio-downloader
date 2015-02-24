require 'mechanize'
module SilvioDownloader
  class Show < JSONable
    attr_accessor :name
    attr_accessor :seasson
    attr_accessor :episode
    attr_accessor :quality

    def self.new_with_description(tvshow_description)

      params = tvshow_description.split('.')
      seasson_string = params[params.count-2].gsub(/s|e/i, '')
      name = params[0..params.count-3].join(' ')
      seasson = seasson_string[0..1].to_i
      episode = seasson_string[2..3].to_i
      quality = params.last
      Show.new.tap do |show|
        show.name = name.gsub(/\w+/) {|w| w.capitalize }
        show.seasson = seasson
        show.episode = episode
        show.quality = quality.upcase
      end
    end

    def quality_string
      return self.quality == "HD" ? "720p" : "HDTV"
    end

    def next_episode_name
      episode_name = "%.2d" % (self.episode + 1)
      seasson_name = "%.2d" % self.seasson
      "#{name} S#{seasson_name}E#{episode_name} #{quality_string}"
    end

    def next_seasson_name
      seasson_name = "%.2d" % (self.seasson + 1)
      "#{name} S#{seasson_name}E01 #{quality_string}"
    end

    def to_s
      episode_name = "%.2d" % self.episode
      seasson_name = "%.2d" % self.seasson
      "#{name} S#{seasson_name}E#{episode_name} #{quality_string}"
    end

    def find_link(link)
      agent = Mechanize.new
      agent.get(link)

      best_link = agent.page.links_with(:href => /magnet/).first
      return nil if best_link.nil?

      best_link.href
    end

    def find_best_link_episode
      find_link("https://thepiratebay.se/search/#{next_episode_name} -(sneak.peek) -(cocain) -(evo)/0/7/208")
    end

    def find_best_link_seasson
      find_link("https://thepiratebay.se/search/#{next_seasson_name} -(sneak.peek) -(cocain) -(evo)/0/7/208")
    end

    def update_to_next_seasson
      self.seasson += 1
      self.episode =  1
    end

    def update_to_next_episode
      self.episode += 1
    end
  end
end