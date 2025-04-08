#!/bin/bash

if ! pacman -Q nomachine &> /dev/null; then
  echo "NoMachine no está instalado. Instalando..."

  mkdir -p ~/.config/pulse
  echo "autospawn = no" > ~/.config/pulse/client.conf
  echo "daemon-binary = /bin/true" >> ~/.config/pulse/client.conf
  echo "enable-shm = false" >> ~/.config/pulse/client.conf

  echo "CLIENTE PULSE:"
  cat ~/.config/pulse/client.conf

  yay -S --noconfirm --norebuild  nomachine
else
  echo "NoMachine ya está instalado."
fi
export PATH=$PATH:/usr/nx
exec "$@"
