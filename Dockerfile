FROM fedora
MAINTAINER Binan AL Halabi <binanalhalabi@yahoo.com>


COPY rtpengine-conf	/etc/default/rtpengine-conf
COPY rtpengine_Install.sh	/usr/local/bin/
COPY rtpengine-start	/usr/local/bin/

RUN chmod +x /usr/local/bin/rtpengine_Install
RUN chmod +x /usr/local/bin/rtpengine-start
RUN /usr/local/bin/rtpengine_Install
RUN /usr/local/bin/rtpengine-start /etc/default/rtpengine-conf 
