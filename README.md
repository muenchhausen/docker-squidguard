# Introduction

this Dockerfile is an [squidGuard](http://www.squidguard.org/) addition to [sameersbn/docker-squid](https://github.com/sameersbn/docker-squid). I find squidGuard very useful to limit access to certain internet pages and to reduce the risk for downloading dangerous software. A central filtering solution is preferred especially if you have a family with children and different devices.

# Installation

Pull the image from the docker registry e.g.

```docker pull muenchhausen/docker-squidguard```

or build it

```git clone https://github.com/muenchhausen/docker-squidguard.git
cd docker-squidguard
docker build --tag="$USER/squidguard" .```

Please refer to [sameersbn/docker-squid](https://github.com/sameersbn/docker-squid) for details!

# Quick Start

Run the downloaded image

```docker run --name='squidguard' -it --rm -p 3128:3128 muenchhausen/docker-squidguard:latest```

or as daemon

```docker run -d --name='squidguard' -it -p 3128:3128 muenchhausen/docker-squidguard:latest```

# Test it 

here you should get the page:
```curl --proxy 192.168.59.103:3128 https://en.wikipedia.org/wiki/Main_Page```

here an example of an advertising domain from the adv blacklist - you should get blocked:
```curl --proxy 192.168.59.103:3128 http://www.linkadd.de```

Now you can conigure the docker IP and Port 3128 in the proxy settings of your operating system or your browser.


# Configuration

For Squid basis configuration, please refer to the documentation of [sameersbn/docker-squid](https://github.com/sameersbn/docker-squid).

The central configuration file of squidGuard is `squidGuard.conf`. You can customize it either by building your own docker image or by specifying the `-v /path/on/host/to/squidGuard.conf:/etc/squidguard/squidGuard.conf` flag in the docker run command. 

# Shell Access

For debugging and maintenance purposes you may want access the containers shell via `docker exec` command.

```docker exec -it squidguard bash```
or
```docker ps```
```docker exec -it <container-id> bash```
