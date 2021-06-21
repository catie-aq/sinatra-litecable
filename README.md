# Web + Websocket server

Applications built with [Sinatra](http://www.sinatrarb.com) and Lite Cable.
LSL version works with JRuby instead of MRI Ruby (standard). 

## Windows WSL -- LSL instead of Redis

With Windows WSL, install JRuby through RBenv.

``` bash
rbenv local jruby-9.2.11.1
bundle install
bundle exec puma
```

## Redis configuration 

You can change the redis server configuration in the file `config/connection_redis.yaml`. 

## Usage

Install dependencies:

```sh
bundle install
```

Run server:

```sh
bundle exec puma
```

## Windows 


It is possible to run Ruby apps in Windows easily with the [Ruby Installer](https://rubyinstaller.org/downloads/). 

> Tested with version  2.7.2 - [download](https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-2.7.2-1/rubyinstaller-devkit-2.7.2-1-x64.exe)

Install it with all options and dependencies, then navigate to the folder. 

``` 
ridk exec bundle install 
```

Run it: 

```
ridk exec bundle exec puma
```
