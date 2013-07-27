Silvio Downloader
=================

Silvio Downloader is an automatic TVShow torrent downloader from The Pirate Bay.
It support only transmission for now.

Instalation
-----------

### Install ruby

Officially supported version is > 2.0.0

[I recommend install rvm](https://rvm.io/rvm/install), and after:

```
rvm install 2.0.0
rvm --default use 2.0.0
```

### Install bundler

```
gem install bundler
```

### Install tranmission

How to install transmission-daemon here.

### Clone this repository:

```
$ git clone https://github.com/leonardoobaptistaa/silvio-downloader.git 
```

### Configure ./config/silvio-downloader.json

```
cd silvio-downloader
cp config/silvio-downloader.json.sample config/silvio-downloader.json
```

Check configuration section to check whole json file

### Setup

```
bundle
```

### Running every x hours

```
bundle exec clockwork lib/silvio-downloader/clock.rb &
```

Configuration
-------------

For now, the configuration is a json file stored at ./config/silvio-downloader.json

```
{
  "shows": [
    {
  "name": "Dexter",
  "seasson": 8,
  "episode": 4,
  "quality": "HD"
},
    {
  "name": "Suits",
  "seasson": 3,
  "episode": 2,
  "quality": "HD"
}
  ],
  "hour_interval": 1,
  "download_path": "/home/user/TvShows/",
  "transmission_host": "127.0.0.1",
  "transmission_port": "9091",
  "transmission_user": "user",
  "transmission_password": "password"
}
```

How to contribuite
------------------

* Fork this project
* Run tests using bundle exec rspec OR bundle exec guard
* It will be nice to implement some of this features
  * Other torrent sites support
  * Other torrent clients support
  * Easy install
  * Sinatra web interface to modify config file
  * Subtitles support
* Make sure to have tests and make a pull request :)