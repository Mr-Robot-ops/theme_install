#!/bin/bash

# Überprüfen, ob das Skript als root ausgeführt wird
if [ "$EUID" -ne 0 ]; then
    echo "Bitte führe das Skript mit sudo oder als root aus."
    exit 1
fi

# Verzeichnisse und Dateien
REPO_DIR="/root/repository"
POSH_THEME_DIR="/root/.poshthemes"
FISH_CONFIG_DIR="/root/.config/fish"
POSH_BIN_DIR="/root/bin"  # Benutzerdefiniertes Verzeichnis für oh-my-posh
FIGLET_FONTS_DIR="/usr/share/figlet"

# Entfernen der Oh My Posh-Installation
echo "Entferne Oh My Posh..."
if [ -d "$POSH_BIN_DIR" ]; then
    sudo rm -rf "$POSH_BIN_DIR/oh-my-posh"
else
    echo "Oh My Posh ist nicht installiert."
fi

# Entfernen von figlet
echo "Entferne figlet..."
if dpkg -l | grep -q figlet; then
    sudo apt remove -y figlet
else
    echo "figlet ist nicht installiert."
fi

# Entfernen von lsd
echo "Entferne lsd..."
if snap list | grep -q lsd; then
    sudo snap remove lsd
else
    echo "lsd ist nicht installiert."
fi

# Entfernen von fish
echo "Entferne fish..."
if dpkg -l | grep -q fish; then
    sudo apt remove -y fish
else
    echo "fish ist nicht installiert."
fi

# Entfernen von lolcat
echo "Entferne lolcat..."
if dpkg -l | grep -q lolcat; then
    sudo apt remove -y lolcat
else
    echo "lolcat ist nicht installiert."
fi

# Entfernen des geklonten Repositories
if [ -d "$REPO_DIR" ]; then
    echo "Entferne Repository-Verzeichnis..."
    sudo rm -rf "$REPO_DIR"
else
    echo "Das Repository-Verzeichnis existiert nicht."
fi

# Entfernen der kopierten Dateien
echo "Entferne kopierte Dateien..."
if [ -f "$POSH_THEME_DIR/wholespace.omp.json" ]; then
    sudo rm -f "$POSH_THEME_DIR/wholespace.omp.json"
else
    echo "Die Datei $POSH_THEME_DIR/wholespace.omp.json existiert nicht."
fi

if [ -f "$FISH_CONFIG_DIR/config.fish" ]; then
    sudo rm -f "$FISH_CONFIG_DIR/config.fish"
else
    echo "Die Datei $FISH_CONFIG_DIR/config.fish existiert nicht."
fi

# Entfernen der Verzeichnisse, wenn sie leer sind
if [ -d "$POSH_THEME_DIR" ] && [ -z "$(ls -A $POSH_THEME_DIR)" ]; then
    sudo rmdir "$POSH_THEME_DIR"
fi

if [ -d "$FISH_CONFIG_DIR" ] && [ -z "$(ls -A $FISH_CONFIG_DIR)" ]; then
    sudo rmdir "$FISH_CONFIG_DIR"
fi

# Entfernen des Fish-PPA
echo "Entferne das Fish PPA..."
if [ -f /etc/apt/sources.list.d/fish-shell-ubuntu-release-3-jammy.list ]; then
    sudo rm /etc/apt/sources.list.d/fish-shell-ubuntu-release-3-jammy.list
    sudo apt update
else
    echo "Das Fish PPA ist nicht vorhanden."
fi

echo "Deinstallation abgeschlossen."

# Starte eine neue Bash-Sitzung
exec bash
