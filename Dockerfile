FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    xfce4 \
    xrdp \
    x11vnc \
    supervisor \
    net-tools \
    curl

RUN wget https://s03.winiso.pl/files/Windows10/pl-pl_windows_10_multi_editions_version_22h2_updated_august_2022_x64_d5ea3411.iso && mount -o loop pl-pl_windows_10_multi_editions_version_22h2_updated_august_2022_x64_d5ea3411.iso /mnt && cd /mnt && ./setup.exe && yum install xrdp && systemctl start xrdp && rdesktop -u wudysoft -p AyGemuy24 127.0.0
