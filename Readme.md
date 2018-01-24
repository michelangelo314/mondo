# Turtle Power - Mondo

Cowabunga dudes! Mondo brings us the unified xmr-stak (https://github.com/fireice-uk/xmr-stak/) wrapped up tight in a docker calzone.

### Getting Started

Mondo can be installed on linux using curl:

```
$ curl -sL https://raw.githubusercontent.com/michelangelo314/mondo/master/install.sh | bash
Installing the turtlepower miner!
Docker found at [/usr/bin/docker]
Using default tag: latest
latest: Pulling from turtlepower/mondo
Digest: sha256:f4bbe5a8ecf079f97693cc580b6545bacd51a7b21ec58c18b4bccfbecb659e27
Status: Image is up to date for turtlepower/mondo:latest
Installing mondo script. I require sudo for this to install to /usr/local/bin/mondo
Miner configuration file installed to /usr/local/etc/mondo-config.txt
Open your config file with a text editor and change it to use your pool and wallet information.
Miner app file installed to /usr/local/bin/mondo
Turtle power miner installed! Make sure /usr/local/bin/mondo is on your path and call mondo. Cowabunga!!
```

If you dont have docker, it will be installed using apt via sudo. The installer will prompt you for sudo access to put the config file into `/usr/local/etc` and the mondo script executible into `/usr/local/bin`. Mondo assumes your user has docker privileges.

After the installer is completed go ahead and edit the config file and add your pool and wallet details

```
$ sudo vim /usr/local/etc/mondo-config.txt
```

The install puts mongo on your path and using it is easy

```
$ mondo start
Starting up docker
8746b6c8f7f5fc1208c4068636016800b465a80eedafc373d96ed778bfa4c9ce
turtlepower-mondo
Cowabunga!! You're miner is running. Use mondo stop to stop the miner. Connect to the miner web interface using localhost:8080!! TURTLE POWER!!
```

Now you're mining! Cowabunga!! You can check your stats using the xmr-stak http interface from your brower or simply from curl

```
curl localhost:8080/h
<html><head><title>Hashrate Report</title></head><body><pre>HASHRATE REPORT
| ID | 2.5s |  60s |  15m | ID | 2.5s |  60s |  15m |
|  0 | 29.8 | 25.4 | (na) |  1 | 33.4 | 25.1 | (na) |
-----------------------------------------------------
Totals:   63.2 50.5 (na) H/s
Highest:  60.5 H/s
```

Go order some pizza and watch the turles roll in!

### Prerequisites

* Docker (https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04)
* curl (`sudo apt-get -y install curl`)
* pepperoni

