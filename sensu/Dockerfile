FROM    base14 

MAINTAINER Sergey Holota serg.holota@gmail.com

# ----------------- #
#      Install      #
# ----------------- #

RUN     apt-get update
RUN     wget http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
RUN     apt-key add rabbitmq-signing-key-public.asc
RUN     echo "deb     http://www.rabbitmq.com/debian/ testing main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list
RUN     wget -q http://repos.sensuapp.org/apt/pubkey.gpg -O- | sudo apt-key add -
RUN     echo "deb     http://repos.sensuapp.org/apt sensu main" | sudo tee /etc/apt/sources.list.d/sensu.list
RUN     apt-get update

RUN     apt-get -y install erlang-nox rabbitmq-server redis-server sensu supervisor uchiwa
RUN     apt-get install -y ruby ruby-dev build-essential sysstat bsd-mailx
RUN     gem install sensu-plugin --no-rdoc --no-ri
RUN     /opt/sensu/embedded/bin/gem install influxdb

# ----------------- #
#   Configuration   #
# ----------------- #

ADD     ./config.json /etc/sensu/config.json
ADD     ./uchiwa.json /etc/sensu/uchiwa.json
ADD     ./main.cf /etc/postfix/main.cf

EXPOSE 5672
EXPOSE 4567
EXPOSE 6379
EXPOSE 4000

# -------- #
#   Run!   #
# -------- 

ADD start.sh /tmp/start.sh
RUN chmod +x /tmp/start.sh

ENTRYPOINT ["/tmp/start.sh"]
