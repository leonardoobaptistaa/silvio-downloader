$LOAD_PATH.unshift( File.expand_path('../../../lib', __FILE__) )

require 'silvio-downloader'
require 'clockwork'
require 'rtransmission'

include Clockwork

@config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
@session = RTransmission::Client.session(
      user: @config.torrent_user,
      password: @config.torrent_password,
      host: @config.torrent_host,
      port: @config.torrent_port
    )

handler do |job|
  downloader = Downloader.new(@session, RTransmission::Torrent)
  downloader.check_new_downloads
end

every(@config.hour_interval.hours, 'check_new_torrents.job')
