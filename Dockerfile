FROM microsoft/windowsservercore

# Install RDP
RUN dism /online /enable-feature /featurename:RemoteDesktop-Core /all /NoRestart

# Install Kubernetes
RUN powershell -Command \
    Invoke-WebRequest -Uri https://aka.ms/kubernetes -OutFile kubernetes.msi ; \
    Start-Process msiexec.exe -ArgumentList '/i', 'kubernetes.msi', '/qn' -NoNewWindow -Wait

# Enable Keep Alive
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name 'KeepAliveEnable' -Value 1

# Expose RDP port
EXPOSE 3389

# Start RDP
CMD ["C:\\Windows\\System32\\mstsc.exe"]
