$LOAD_PATH.unshift( File.expand_path('../lib', __FILE__) )
require 'silvio-downloader'

namespace :shows do
  desc "Add tv serie to config file"
  task :add, [:tvshow_description] do |t, args|
    config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
    new_show = SilvioDownloader::Show.new_with_description(args[:tvshow_description])
    exists = false
    config.shows.each do |show|
      next if show.name != new_show.name
      show.episode = new_show.episode
      show.seasson = new_show.seasson
      show.quality = new_show.quality
      exists = true
      break
    end
    config.shows << new_show unless exists
    config.update
  end

  desc "Remove tv serie to config file"
  task :rm, [:tvshow_name] do |t, args|
    show_name = args[:tvshow_name].gsub('.', ' ').gsub(/\w+/) {|w| w.capitalize }
    config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
    config.shows.select{|s| s.name == show_name}.each do |show_to_remove|
      config.shows.delete(show_to_remove)
    end
    config.update
  end

  desc "List all shows"
  task :list do
    config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
    config.shows.each do |show|
      puts show
    end
  end
end

namespace :torrent do
  
end