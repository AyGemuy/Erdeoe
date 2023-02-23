FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Install RDP
RUN dism /online /enable-feature /featurename:RemoteDesktop-Core /all /norestart

# Set Administrator password
RUN net user administrator /passwordreq:yes
RUN net user administrator *

# Expose RDP port
EXPOSE 3389

# Set RDP to allow connections
RUN reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f

# Start RDP service
CMD ["C:\\Windows\\System32\\svchost.exe", "-k", "termsvcs"]
