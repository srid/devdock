CWD := $(shell pwd)

all:
	@true

d-create:
	sudo docker build -t devdock .

d-launch:
	sudo docker run -d -cidfile=/tmp/devdock.cid devdock
	sudo docker logs `sudo docker ps -l -q`
	sudo docker port `sudo docker ps -l -q` 22

d-ps:
	sudo docker ps | grep devdock

d-ssh:
	ssh -t root@localhost -p $(shell sudo docker port `cat /tmp/devdock.cid` 22)

d-kill:
	sudo docker kill `cat /tmp/devdock.cid`
	sudo rm -f /tmp/devdock.cid
