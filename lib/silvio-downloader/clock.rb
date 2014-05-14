$LOAD_PATH.unshift( File.expand_path('../../../lib', __FILE__) )

require 'silvio-downloader'
require 'clockwork'
require 'logger'
require 'rtransmission'

include Clockwork

@config = read_config
@logger = Logger.new('log/silvio_downloader.log')

@session = RTransmission::Client.session(
      user: @config.torrent_user,
      password: @config.torrent_password,
      host: @config.torrent_host,
      port: @config.torrent_port
    )

handler do |job|
  @config = read_config
  @logger.info('Loading config/silvio-downloader.json')
  @config.shows.each do |show|
    next if download_next_episode(show, show.find_best_link_episode)
    next if download_next_episode(show, show.find_best_link_seasson, true)
  end

  @logger.info('Finishing run')
end

every(@config.hour_interval.hours, 'check_new_torrents.job')

def read_config
  SilvioDownloader::Configuration.new('config/silvio-downloader.json')
end

def download_next_episode(show, link, update_to_next_seasson = false)
  return false if link.nil?

  download_path = "#{@config.download_path}/#{show.name}"
  @logger.info("Adding #{show.next_episode_name}")
  @logger.info("Download path set to #{download_path}")

  begin
    RTransmission::Torrent.add(@session, url: link, download_dir: download_path)
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