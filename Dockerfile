FROM lopsided/archlinux:latest

RUN pacman -Syu --noconfirm sudo git && \
    useradd -m builder -u 1001 && \
    echo "builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    mkdir -p /__w /github/home /github/workflow

RUN pacman-key --recv-key <PIPA_ALARM_KEY_FINGERPRINT> --keyserver keyserver.ubuntu.com && \
    pacman-key --lsign-key <PIPA_ALARM_KEY_FINGERPRINT> && \
    echo "[pipa-alarm]" >> /etc/pacman.conf && \
    echo "SigLevel = Required DatabaseOptional" >> /etc/pacman.conf && \
    echo "Server = https://pipa-alarm.github.io/repo" >> /etc/pacman.conf && \
    pacman -Sy --noconfirm pipa-alarm-keyring base-devel && \
    pacman-key --populate

ENV HOME=/home/builder
USER builder
WORKDIR /home/builder
