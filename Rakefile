$LOAD_PATH.unshift( File.expand_path('../lib', __FILE__) )

require 'silvio-downloader'

desc 'Start sinatra server'
task 'server' do 	
  
end

desc 'Check for new episodes'
task 'check' do
  require 'rtransmission'
  config = SilvioDownloader::Configuration.new('config/silvio-downloader.json')
  config.shows.each do |show|
    download_path = "#{config.download_path}#{show.name}"
    link = show.find_best_link_episode

    session = RTransmission::Client.session(
      user: config.transmission_user,
      password: config.transmission_password,
      host: config.transmission_host,
      port: config.transmission_port
    )

    if link.nil? == false
      RTransmission::Torrent.add(session, :url => link, :'download-dir' => download_path)
      show.update_to_next_episode
      next
    end

    link = show.find_best_link_seasson

    if link.nil? == false
      RTransmission::Torrent.add(session, :url => link, :'download-dir' => download_path)
      show.update_to_next_seasson
      next
    end
  end
  config.update
end