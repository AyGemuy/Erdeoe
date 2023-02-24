FROM scottyhardy/docker-wine:latest

RUN apt-get update && apt-get install -y xrdp

RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip

RUN unzip ngrok-stable-linux-amd64.zip

RUN rm ngrok-stable-linux-amd64.zip

EXPOSE 3389

CMD ["xrdp", "-n"]

ENTRYPOINT ["/ngrok", "tcp", "3389"]
