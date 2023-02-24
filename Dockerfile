FROM mcr.microsoft.com/windows/servercore:ltsc2019

RUN powershell -Command \
    Invoke-WebRequest https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-windows-amd64.zip -OutFile ngrok.zip \
    Expand-Archive ngrok.zip \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0 \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop" \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1 \
    Set-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "P@ssw0rd!" -Force)

CMD .\ngrok\ngrok.exe authtoken 1pRvfePyCgaa2xZw3Wk4VxOANxA_5KEgrVHxaV9XohEnzDe3S \
    .\ngrok\ngrok.exe tcp 3389 \
    echo "RDP URL: $(.\ngrok\ngrok.exe http --log=stdout 3389 | Select-String -Pattern "url" | Select-Object -ExpandProperty Matches).Value"
