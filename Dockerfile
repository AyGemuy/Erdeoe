FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    xfce4 \
    xrdp \
    x11vnc \
    supervisor \
    net-tools \
    curl

RUN mkdir -p /var/run/dbus \
    && dbus-uuidgen > /var/run/dbus/machine-id

RUN curl -sL https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip \
    && unzip ngrok.zip -d /usr/local/bin \
    && rm ngrok.zip

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3389

CMD ["/usr/bin/supervisord"]
