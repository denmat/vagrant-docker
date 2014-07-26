FROM denmat/oracle_base_65

MAINTAINER DenMat <tu2bgone@gmail.com>

RUN yum install -y http://yum.puppetlabs.com/puppetlabs-release-el-6.noarch.rpm
RUN yum install -y puppet-3.6.2-1.el6 facter-2.1.0-1.el6
RUN yum clean all 

RUN service sshd start
RUN service sshd stop

ADD files/sshd_config /etc/ssh/sshd_config
ADD files/id_rsa.pub /home/vagrant/.ssh/authorized_keys
ADD files/sudoers.d.vagrant /etc/sudoers.d/container_users 

RUN chown vagrant.vagrant /home/vagrant/.ssh/authorized_keys
RUN chmod 640 /home/vagrant/.ssh/authorized_keys

EXPOSE 22
EXPOSE 53
EXPOSE 8140
