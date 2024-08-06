#!/bin/bash

# Überprüfen, ob das Skript als root ausgeführt wird
if [ "$EUID" -ne 0 ]; then
    echo "Bitte führe das Skript mit sudo oder als root aus."
    exit 1
fi

# Verzeichnisse und Dateien
REPO_URL="https://github.com/Mr-Robot-ops/theme_install.git"
REPO_DIR="$HOME/repository"
POSH_THEME_DIR="$HOME/.poshthemes"
FISH_CONFIG_DIR="$HOME/.config/fish"

# Überprüfen, ob Git installiert ist, und falls nicht, installieren
if ! command -v git &> /dev/null; then
    echo "Git ist nicht installiert. Installiere Git..."
    apt update
    apt install -y git
fi

# Oh My Posh installieren
echo "Installiere Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/bin

# Snap installieren
echo "Installiere Snap..."
apt update
apt install -y snapd

# lolcat installieren
echo "Installiere lolcat..."
snap install lolcat

# figlet installieren
echo "Installiere figlet..."
apt install -y figlet

# lsd installieren
echo "Installiere lsd..."
apt install -y lsd

# Repository klonen oder aktualisieren
if [ -d "$REPO_DIR" ]; then
    echo "Das Verzeichnis $REPO_DIR existiert bereits. Aktualisiere Repository..."
    cd "$REPO_DIR" && git pull
else
    echo "Klone Repository..."
    git clone "$REPO_URL" "$REPO_DIR"
fi

# Dateien kopieren
echo "Kopiere Dateien..."

# .poshthemes Verzeichnis erstellen, falls es nicht existiert
mkdir -p "$POSH_THEME_DIR"

# wholespace.omp.json kopieren
cp -f "$REPO_DIR/wholespace.omp.json" "$POSH_THEME_DIR/wholespace.omp.json"
echo "wholespace.omp.json nach $POSH_THEME_DIR kopiert."

# .config/fish Verzeichnis erstellen, falls es nicht existiert
mkdir -p "$FISH_CONFIG_DIR"

# config.fish kopieren
cp -f "$REPO_DIR/config.fish" "$FISH_CONFIG_DIR/config.fish"
echo "config.fish nach $FISH_CONFIG_DIR kopiert."

# Temporäre Dateien und geklontes Repository löschen
echo "Bereinige temporäre Dateien..."
rm -rf "$REPO_DIR"
