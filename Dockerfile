FROM microsoft/windowsservercore

# Install RDP
RUN dism.exe /online /enable-feature /featurename:RemoteDesktop-Core /all /norestart

# Set up firewall
RUN netsh advfirewall firewall add rule name="RDP" dir=in action=allow protocol=TCP localport=3389

# Set up keep alive
RUN reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v KeepAliveEnable /t REG_DWORD /d 1

# Expose port
EXPOSE 3389

# Start RDP
CMD ["C:\\Windows\\System32\\mstsc.exe"]
