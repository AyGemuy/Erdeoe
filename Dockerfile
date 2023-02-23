FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Install Chocolatey
RUN Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install .NET Core SDK
RUN choco install dotnetcore-sdk --version 2.2.203 -y

# Install IIS
RUN Add-WindowsFeature Web-Server

# Install ASP.NET
RUN Install-WindowsFeature NET-Framework-45-ASPNET ; \
    Install-WindowsFeature Web-Asp-Net45

# Install PowerShell
RUN choco install powershell-core --version 6.2.3 -y

# Set up environment
ENV PSModulePath C:\Program Files\PowerShell\Modules

# Set up IIS
RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISSite -Name 'Default Web Site' -PhysicalPath C:\inetpub\wwwroot -BindingInformation "*:80:"

# Set up ASP.NET
RUN powershell -NoProfile -Command \
    Import-module IISAdministration; \
    New-IISApplicationPool -Name 'DefaultAppPool'; \
    Set-ItemProperty -Path 'IIS:\AppPools\DefaultAppPool' -Name managedRuntimeVersion -Value ''; \
    New-WebApplication -Name 'Default Web Site' -Site 'Default Web Site' -PhysicalPath 'C:\inetpub\wwwroot' -ApplicationPool 'DefaultAppPool'

# Set up PowerShell
RUN powershell -NoProfile -Command \
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine

# Set up Web Server
RUN powershell -NoProfile -Command \
    Start-Service W3SVC

# Expose port 80
EXPOSE 80

# Start Web Server
CMD ["powershell", "-NoProfile", "-Command", "Start-Service W3SVC"]
