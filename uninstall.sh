#!/bin/bash

# Überprüfen, ob das Skript als root ausgeführt wird
if [ "$EUID" -ne 0 ]; then
    echo "Bitte führe das Skript mit sudo oder als root aus."
    exit 1
fi

# Verzeichnisse und Dateien
REPO_DIR="$HOME/repository"
POSH_THEME_DIR="$HOME/.poshthemes"
FISH_CONFIG_DIR="$HOME/.config/fish"

# Entfernen der Oh My Posh-Installation
echo "Entferne Oh My Posh..."
sudo rm -rf "$HOME/bin/oh-my-posh"

# Entfernen von Snap und Snap-Paketen
echo "Entferne Snap und Snap-Pakete..."
sudo snap remove lolcat
sudo apt remove -y snapd

# Entfernen von figlet
echo "Entferne figlet..."
sudo apt remove -y figlet

# Entfernen von lsd
echo "Entferne lsd..."
sudo apt remove -y lsd

# Entfernen des geklonten Repositories
if [ -d "$REPO_DIR" ]; then
    echo "Entferne Repository-Verzeichnis..."
    sudo rm -rf "$REPO_DIR"
fi

# Entfernen der kopierten Dateien
echo "Entferne kopierte Dateien..."
sudo rm -f "$POSH_THEME_DIR/wholespace.omp.json"
sudo rm -f "$FISH_CONFIG_DIR/config.fish"

# Entfernen der Verzeichnisse, wenn sie leer sind
sudo rmdir "$POSH_THEME_DIR" 2>/dev/null
sudo rmdir "$FISH_CONFIG_DIR" 2>/dev/null

echo "Deinstallation abgeschlossen."
