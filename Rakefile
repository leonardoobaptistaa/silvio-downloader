$LOAD_PATH.unshift( File.expand_path('../lib', __FILE__) )
require 'silvio-downloader'
require 'rtransmission'

task :check do
  @config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
  @session = RTransmission::Client.session(
    user: @config.torrent_user,
    password: @config.torrent_password,
    host: @config.torrent_host,
    port: @config.torrent_port
  )

  downloader = Downloader.new(@session, RTransmission::Torrent)
  downloader.check_new_downloads
end

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

namespace :configure do
  desc "First configuration"
  task :first_run do
    FileUtils.cp('config/silvio-downloader.json.sample', 'config/silvio-downloader.json')
    config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
    config.update

    unless File.directory?('log')
      Dir.mkdir('log')
      File.open('log/silvio_downloader.log', 'w') {
        |file| file.write("file created")
      }
    end
  end

  desc "Download path"
  task :download_path, [:path] do |t, args|
    config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
    config.download_path = args[:path].chomp("/")
    config.update
    puts "Download path set to: #{config.download_path}"
  end
end

namespace :torrent do

end