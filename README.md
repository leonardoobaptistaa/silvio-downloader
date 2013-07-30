Silvio Downloader
=================

Silvio Downloader is an automatic TVShow torrent downloader from The Pirate Bay.

Dependencies
------------

* Ruby 2
* Supported torrent client
  * [Transmission](http://www.transmissionbt.com/)

Choose a torrent client
-----------------------

#### [Transmission](http://www.transmissionbt.com/)

You can set your transmission client to run as daemon or a normal torrent client, 
but it need to have the web interface configured.

Instructions to enable web interface: 
 * [OSX](https://trac.transmissionbt.com/wiki/OSX/DesktopRemote)
 * [Ubuntu as Daemon](http://rickylford.com/transmission-on-ubuntu-server-12-04-lts/)

Install Silvio Downloader Gem
-----------------------------

```
gem install silvio-downloader
silvio configure
silvio start
```

Aditional configuration
-----------------------

* Adding a new show with episode and seasson numbers

```
silvio add Dexter.s080e05.HD
silvio add The.Big.Bang.Theory.s040e22.HD
```

* Removing a show

```
silvio rm Dexter
silvio rm The.Big.Bang.Theory
```

* Listing Shows

```
silvio shows
```

* Torrent client

```
silvio torrent transmission user:password@192.168.1.99:9091
-> Ok
```

How to contribuite
------------------

* Fork this project
* Run tests using bundle exec rspec OR bundle exec guard
* It will be nice to implement some of this features
  * Other torrent clients support
  * Easy install
  * Sinatra web interface to modify config file
  * Subtitles support
* Make sure to have tests and make a pull request :)