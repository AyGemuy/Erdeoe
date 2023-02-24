FROM microsoft/windowsservercore

# Install RDP
RUN dism.exe /online /enable-feature /featurename:RemoteDesktop-Gateway /all /NoRestart
RUN dism.exe /online /enable-feature /featurename:RemoteDesktop-Gateway-Server /all /NoRestart

# Install Ngrok
RUN powershell -Command \
    Invoke-WebRequest -Uri "https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip" -OutFile "ngrok.zip"; \
    Expand-Archive -Path ngrok.zip -DestinationPath C:\ngrok; \
    Remove-Item -Path ngrok.zip

# Configure Ngrok
RUN powershell -Command \
    $ngrokPath = "C:\ngrok\ngrok.exe"; \
    $ngrokAuthtoken = "1pRvfePyCgaa2xZw3Wk4VxOANxA_5KEgrVHxaV9XohEnzDe3S"; \
    & $ngrokPath authtoken $ngrokAuthtoken

# Expose port 3389
EXPOSE 3389

# Start Ngrok
CMD ["C:\\ngrok\\ngrok.exe", "tcp", "3389"]
