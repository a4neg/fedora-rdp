FROM fedora:latest

ENV LANG ru_RU.UTF-8
ENV LANGUAGE ru_RU:RU
ENV LC_ALL ru_RU.UTF-8

RUN dnf -y groupinstall 'LXDE Desktop' && \
    dnf -y install \
    supervisor \
    xrdp \
    xrdp-keygen \
    http://kdl1.cache.wps.com/ksodl/download/linux/a21//wps-office-10.1.0.5707-1.a21.x86_64.rpm \
    firefox \
    imagemagick \
    libgsf \
    t1utils \
    cabextract \
    unixODBC \
    curl \
    policycoreutils-python \
    xorg-x11-font-utils \
    fontconfig \
    https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm 
    && dnf clean all

ADD rpm/*.rpm /tmp/
RUN yum -y localinstall /tmp/*.rpm

RUN useradd -u datch -r -g 0 -d ${HOME} -s /sbin/nologin -c " User" datch && \
    chmod g+w /etc/xrdp && \
    chmod u+s /usr/sbin/xrdp-sesman && \
    chmod u+s /usr/sbin/xrdp && \
    mkdir -p /home/datch && \
    chown -R datch:0 ${HOME} 

# http://sigkillit.com/2013/02/26/how-to-remotely-access-linux-from-windows/
COPY etc/ /etc/

# Allow all users to connect via RDP.
RUN sed -i '/TerminalServerUsers/d' /etc/xrdp/sesman.ini && \
    sed -i '/TerminalServerAdmins/d' /etc/xrdp/sesman.ini \

ADD   km-0809.ini /etc/xrdp/km-0809.ini
RUN   chmod 644 /etc/xrdp/km-0809.ini

ADD startup.sh /root/startup.sh
CMD ["/bin/bash", "/root/startup.sh"]

EXPOSE 3389

LABEL INSTALL="docker run -d --net=host --name NAME IMAGE"

