$LOAD_PATH.unshift( File.expand_path('../../../lib', __FILE__) )

require 'silvio-downloader'
require 'clockwork'
require 'logger'

include Clockwork

logger = Logger.new('log/silvio_downloader.log')

handler do |job|
  require 'rtransmission'

  logger.info('Loading config/silvio-downloader.json')
  config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
  config.shows.each do |show|
    download_path = "#{config.download_path}#{show.name}"
    
    session = RTransmission::Client.session(
      user: config.transmission_user,
      password: config.transmission_password,
      host: config.transmission_host,
      port: config.transmission_port
    )

    link = show.find_best_link_episode
    if link.nil? == false
      logger.info("Adding #{show.next_episode_name}")
      logger.info("Download path set to #{download_path}")

      begin
        RTransmission::Torrent.add(session, :url => link, :download_dir => download_path)
        show.update_to_next_episode
        logger.info("Updating configuration file")
        config.update
      rescue Exception => e
        logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
        break
      end

      next
    end

    link = show.find_best_link_seasson
    if link.nil? == false
      logger.info("Adding #{show.next_episode_name}")
      logger.info("Download path set to #{download_path}")

      begin
        RTransmission::Torrent.add(session, :url => link, :download_dir => download_path)
        show.update_to_next_seasson
        logger.info("Updating configuration file")
        config.update
      rescue Exception => e
        logger.error "#{e.message}\n#{e.backtrace.join("\n")}"
        break
      end

      next
    end
  end

  logger.info('Finishing run')
end

config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
every(config.hour_interval.hours, 'check_new_torrents.job')