FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    unzip \
    wget

WORKDIR /opt

RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
RUN unzip ngrok-stable-linux-amd64.zip

EXPOSE 3389

ENTRYPOINT ["./ngrok", "tcp", "3389", "-authtoken", "1pRvfePyCgaa2xZw3Wk4VxOANxA_5KEgrVHxaV9XohEnzDe3S"]
