#!/bin/bash
#Need this for rabbitmq to start
echo  "127.0.0.1 $HOSTNAME" >> /etc/hosts

/etc/init.d/rabbitmq-server start
rabbitmqctl add_vhost /sensu
rabbitmqctl add_user sensu passpass
rabbitmqctl set_permissions -p /sensu sensu ".*" ".*" ".*"
# rabbitmqctl set_user_tags sensu administrator

/etc/init.d/redis-server start
/etc/init.d/sensu-server start
/etc/init.d/sensu-api start
/etc/init.d/sensu-client start
/etc/init.d/uchiwa start

tail -f /var/log/uchiwa.log
fg

# /etc/init.d/sensu-dashboard start
# /usr/sbin/sshd -D -o UseDNS=no -o UsePAM=no
