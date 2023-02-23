FROM mcr.microsoft.com/windows/servercore:latest

RUN powershell -Command \
    $ErrorActionPreference = 'Stop'; \
    $ProgressPreference = 'SilentlyContinue'; \
    Invoke-WebRequest -Uri https://kubernetes.io/docs/tasks/tools/install-kubectl/ -OutFile C:\kubectl.exe; \
    Add-Content -Path 'C:\ProgramData\Docker\config\daemon.json' -Value '{ "live-restore": true }'

CMD ["C:\\kubectl.exe"]
