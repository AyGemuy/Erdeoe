FROM ubuntu:latest

# Install packages
RUN apt-get update && apt-get install -y \
    xrdp \
    xfce4 \
    xfce4-goodies \
    tightvncserver \
    && apt-get clean

# Configure xrdp
RUN sed -i 's/^new_cursors=true/new_cursors=false/g' /etc/xrdp/xrdp.ini

# Configure xfce4
RUN echo xfce4-session >/root/.xsession

# Configure keep alive
RUN echo "while true; do sleep 10; done" > /root/keepalive.sh
RUN chmod +x /root/keepalive.sh

# Start xrdp
CMD /etc/init.d/xrdp start && /root/keepalive.sh
