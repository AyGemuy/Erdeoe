FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install RDP
RUN dism.exe /online /enable-feature /featurename:RemoteDesktop-Core /all /norestart

# Install keep alive
RUN powershell -Command \
    wget https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/master/windows-server-container-tools/KeepAlive/Install-ContainerKeepAlive.ps1 -OutFile C:\Install-ContainerKeepAlive.ps1; \
    powershell.exe -ExecutionPolicy Bypass -File C:\Install-ContainerKeepAlive.ps1

# Expose RDP port
EXPOSE 3389

# Start keep alive
CMD ["C:\\KeepAlive\\KeepAlive.exe"]
