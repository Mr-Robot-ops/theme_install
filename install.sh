#!/bin/bash

# Überprüfen, ob das Skript als root ausgeführt wird
if [ "$EUID" -ne 0 ]; then
    echo "Bitte führe das Skript mit sudo oder als root aus."
    exit 1
fi

# Verzeichnisse und Dateien
REPO_URL="https://github.com/Mr-Robot-ops/theme_install.git"
REPO_DIR="/root/repository"
POSH_THEME_DIR="/root/.poshthemes"
FISH_CONFIG_DIR="/root/.config/fish"
POSH_BIN_DIR="/root/bin"  # Benutzerdefiniertes Verzeichnis für oh-my-posh
FIGLET_FONTS_DIR="/usr/share/figlet"

# Überprüfen, ob Git installiert ist, und falls nicht, installieren
if ! command -v git &> /dev/null; then
    echo "Git ist nicht installiert. Installiere Git..."
    apt update
    apt install -y git || { echo "Fehler beim Installieren von Git"; exit 1; }
fi

# Verzeichnis für oh-my-posh erstellen, falls es nicht existiert
mkdir -p "$POSH_BIN_DIR"

# Oh My Posh installieren
echo "Installiere Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$POSH_BIN_DIR" || { echo "Fehler beim Installieren von Oh My Posh"; exit 1; }

# Füge das Installationsverzeichnis zu $PATH hinzu
if ! grep -q "$POSH_BIN_DIR" /root/.bashrc; then
    echo "Füge $POSH_BIN_DIR zu \$PATH hinzu..."
    echo "export PATH=\$PATH:$POSH_BIN_DIR" >> /root/.bashrc
    source /root/.bashrc
fi

# Snap installieren
echo "Installiere Snap..."
apt update
apt install -y snapd || { echo "Fehler beim Installieren von Snap"; exit 1; }

# lolcat installieren
echo "Installiere lolcat..."
snap install lolcat || { echo "Fehler beim Installieren von lolcat"; exit 1; }

# figlet installieren
echo "Installiere figlet..."
apt install -y figlet || { echo "Fehler beim Installieren von figlet"; exit 1; }

# lsd installieren
echo "Installiere lsd..."
snap install lsd --devmode || { echo "Fehler beim Installieren von lsd"; exit 1; }

# fish installieren
echo "Installiere fish..."
apt install -y fish || { echo "Fehler beim Installieren von fish"; exit 1; }

# fish als Standardshell setzen
echo "Setze fish als Standardshell..."
chsh -s /usr/bin/fish || { echo "Fehler beim Setzen von fish als Standardshell"; exit 1; }

# Repository klonen oder aktualisieren
if [ -d "$REPO_DIR" ]; then
    echo "Das Verzeichnis $REPO_DIR existiert bereits. Aktualisiere Repository..."
    cd "$REPO_DIR" && git pull || { echo "Fehler beim Aktualisieren des Repositories"; exit 1; }
else
    echo "Klone Repository..."
    git clone "$REPO_URL" "$REPO_DIR" || { echo "Fehler beim Klonen des Repositories"; exit 1; }
fi

# Dateien kopieren
echo "Kopiere Dateien..."

# .poshthemes Verzeichnis erstellen, falls es nicht existiert
mkdir -p "$POSH_THEME_DIR"

# wholespace.omp.json kopieren
cp -f "$REPO_DIR/wholespace.omp.json" "$POSH_THEME_DIR/wholespace.omp.json" || { echo "Fehler beim Kopieren der wholespace.omp.json"; exit 1; }
echo "wholespace.omp.json nach $POSH_THEME_DIR kopiert."

# .config/fish Verzeichnis erstellen, falls es nicht existiert
mkdir -p "$FISH_CONFIG_DIR"

# config.fish kopieren
cp -f "$REPO_DIR/config.fish" "$FISH_CONFIG_DIR/config.fish" || { echo "Fehler beim Kopieren der config.fish"; exit 1; }
echo "config.fish nach $FISH_CONFIG_DIR kopiert."

# figlet-fonts kopieren
echo "Kopiere figlet-fonts nach $FIGLET_FONTS_DIR..."
mkdir -p "$FIGLET_FONTS_DIR"  # Stelle sicher, dass das Zielverzeichnis existiert
cp -r "$REPO_DIR/figlet-fonts"/* "$FIGLET_FONTS_DIR/" || { echo "Fehler beim Kopieren der figlet-fonts"; exit 1; }
echo "figlet-fonts nach $FIGLET_FONTS_DIR kopiert."

# Temporäre Dateien und geklontes Repository löschen
echo "Bereinige temporäre Dateien..."
rm -rf "$REPO_DIR"

echo "Installation abgeschlossen."

# Wechsle zu fish und lade die Konfiguration
echo "Starte fish und lade die Konfiguration..."
exec fish -c "source $FISH_CONFIG_DIR/config.fish; exec fish"
