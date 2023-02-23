FROM ubuntu:latest

# Install Ngrok
RUN apt-get update && apt-get install -y wget
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip

# Install xrdp
RUN apt-get update && apt-get install -y xrdp

# Expose port
EXPOSE 3389

# Start xrdp and ngrok
CMD xrdp -n && ./ngrok tcp 3389 --log=stdout --log-level=debug --region=us --authtoken=1pRvfePyCgaa2xZw3Wk4VxOANxA_5KEgrVHxaV9XohEnzDe3S --keepalive=true
