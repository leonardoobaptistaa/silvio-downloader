module SilvioDownloader
  class Configuration < JSONable

    attr_accessor :file
    attr_accessor :hour_interval
    attr_accessor :download_path
    attr_accessor :transmission_host
    attr_accessor :transmission_port
    attr_accessor :transmission_user
    attr_accessor :transmission_password
    attr_accessor :shows

    def initialize(file)
      
      config = open(file)
      config_file = config.read
      self.file = File.absolute_path(config.path)
      json = JSON.parse(config_file)

      self.shows = []
      parse_shows( json['shows'] )
      self.hour_interval = json['hour_interval'] || 1
      self.download_path = json['download_path']
      self.transmission_host = json['transmission_host'] || '127.0.0.1'
      self.transmission_port = json['transmission_port'] || '9091'
      self.transmission_user = json['transmission_user'] || 'user'
      self.transmission_password = json['transmission_password'] || 'transmission'
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
      File.open(self.file, 'w').write(self.to_json)
    end
  end
end