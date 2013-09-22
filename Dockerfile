# -*- sh -*-

# TODO:
# * ssh forwarding (for git push)
# * don't work as root
# * `make d-ssh` should not prompt for password
# * abstract this using vagrant? https://github.com/dotcloud/docker/issues/404

FROM dsissitka/ubunturaring
MAINTAINER srid

ENV PACKAGES tmux git tig emacs24-nox openssh-server

RUN sed 's/main$/main universe/' -i /etc/apt/sources.list
RUN apt-get -qy update && apt-get -qy install $PACKAGES && apt-get -qy clean

EXPOSE 22

ENV EDITOR emacs

RUN mkdir /var/run/sshd && /usr/sbin/sshd
RUN echo "root:root" | chpasswd
ADD .bashrc /root/
ADD .emacs /root/

RUN env > /env

CMD ["/usr/sbin/sshd", "-D"]
