#!/bin/bash

if ! pacman -Q nomachine &> /dev/null; then
  echo "NoMachine no está instalado. Instalando..."
  yay -S --noconfirm nomachine
else
  echo "NoMachine ya está instalado."
fi

exec "$@"
