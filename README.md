Silvio Downloader
=================

Silvio Downloader is an automatic TVShow torrent downloader from The Pirate Bay.

Dependencies
------------

* Git
* Ruby 2
* Supported torrent client
  * [Transmission](http://www.transmissionbt.com/)

Choose a torrent client
-----------------------

#### [Transmission](http://www.transmissionbt.com/)

You can set your transmission client to run as daemon or a normal torrent
client, but it need to have the web interface configured.

Instructions to enable web interface:
 * [OSX](https://trac.transmissionbt.com/wiki/OSX/DesktopRemote)
 * [Ubuntu as Daemon](http://rickylford.com/transmission-on-ubuntu-server-12-04-lts/)

Install Silvio Downloader
-------------------------

Make sure that you have Ruby 2, git client and open your terminal.

```
gem install bundler
gem install foreman
git clone git@github.com:leonardoobaptistaa/silvio-downloader.git
cd silvio-downloader
bundle
```

Configure your downloader
-------------------------

First check if this command is working:

```
silvio
```

If not, please substitute ```silvo``` for ```lib/silvio```

* Adding a new show with episode and seasson numbers

You have to add the last episode that you watched. Silvio will download from
there.

```
silvio shows:add dexter.s080e05.hd
silvio shows:add the.big.bang.theory.s040e22.sd
```

* Removing a show

```
silvio shows:rm dexter
silvio shows:rm the.big.bang.theory
```

* Listing Shows

```
silvio shows:list
```

* Download path

```
silvio configure:download_path custom/path/to/download
```

Note: Every Tv Show already have its folder, so if you set your download folder
to ~/Downloads, when silvio downloads a The Walking Dead episode, it will save
on ~/Downloads/The Walking Dead. For now this config cannot be changed.

* Torrent client

You have to open config/silvio-downloader.json file and edit it manually.
You can set things like user, password, torrent client location and port.

Start downloading
-----------------

###Automatic downloads

The best use of Silvio Downloader is to have it running on login by default.
To do this, you can generate start up scrips from foreman export tool.

####Ubuntu (using upstart)

```
foreman export upstart /etc/init -a silvio -u <your-login-user>
sudo start silvio
```

####Mac OS X

TODO - launchd scripts

###Manually

Or you can start downloads manually using

```
foreman start &
```

How to contribuite
------------------

* Fork this project
* Run tests using bundle exec rspec OR bundle exec guard
* It will be nice to implement some of this features
  * Other torrent clients support
  * Sinatra web interface to modify config file
  * Subtitles support
* Make sure to have tests and make a pull request :)