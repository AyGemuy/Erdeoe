FROM scottyhardy/docker-wine:latest

# Install RDP
RUN apt-get update && apt-get install -y xrdp

# Configure RDP
RUN echo "xrdp_keymap=en-us" >> /etc/xrdp/xrdp.ini
RUN echo "xrdp_port=3389" >> /etc/xrdp/xrdp.ini

# Expose port
EXPOSE 3389

# Start RDP
CMD ["/usr/sbin/xrdp", "-nodaemon"]
