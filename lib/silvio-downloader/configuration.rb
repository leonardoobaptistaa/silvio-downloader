module SilvioDownloader
  class Configuration < JSONable

    attr_accessor :file
    attr_accessor :hour_interval
    attr_accessor :download_path
    attr_accessor :torrent_client
    attr_accessor :torrent_host
    attr_accessor :torrent_port
    attr_accessor :torrent_user
    attr_accessor :torrent_password
    attr_accessor :shows

    def initialize(file)
      
      config = open(file)
      config_file = config.read
      self.file = File.absolute_path(config.path)
      json = JSON.parse(config_file)
      config.close

      self.shows = []
      parse_shows( json['shows'] )
      self.hour_interval = json['hour_interval'] || 1
      self.download_path = json['download_path']
      self.torrent_client = json['torrent_client'] || 'transmission'
      self.torrent_host = json['torrent_host'] || '127.0.0.1'
      self.torrent_port = json['torrent_port'] || '9091'
      self.torrent_user = json['torrent_user'] || 'user'
      self.torrent_password = json['torrent_password'] || 'transmission'
    end

    def parse_shows(shows)
      shows.each do |show_json|
        show = Show.new
        show.name = show_json['name']
        show.seasson = show_json['seasson'] || 1
        show.episode = show_json['episode'] || 1
        show.quality = show_json['quality'] || 'HD'
        self.shows << show
      end
    end

    def update
      config_file = File.open(self.file, 'w')
      config_file.write(self.to_json)
      config_file.close
    end
  end
end