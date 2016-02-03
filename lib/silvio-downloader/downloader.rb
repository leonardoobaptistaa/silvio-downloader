require 'logger'

class Downloader
  attr_accessor :session, :torrent, :config, :logger

  def initialize(session, torrent)
    @session = session
    @torrent = torrent

    @logger = Logger.new('log/silvio_downloader.log')
    @config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
  end

  def check_new_downloads
    @config.shows.each do |show|
      @logger.info("Checking #{show.name} ")
      download(show)
    end
    @logger.info('Finishing run')
  end

  def download(show)
    return if download_next_episode(show, show.find_best_link_episode)
    download_next_episode(show, show.find_best_link_seasson, true)
  end

  def download_next_episode(show, link, update_to_next_seasson = false)
    return false if link.nil?

    download_path = "#{@config.download_path}/#{show.name}"
    @logger.info("Adding #{show.next_episode_name}")
    @logger.info("Download path set to #{download_path}")

    begin
      torrent.add(@session, url: link, download_dir: download_path)
    rescue Exception => e
      @logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
      return false
    end

    @logger.info("Updating configuration file")
    if update_to_next_seasson
      show.update_to_next_seasson
    else
      show.update_to_next_episode
    end
    @config.update

    true
  end
end
