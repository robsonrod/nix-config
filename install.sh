#!/usr/bin/env bash
#
# Enhanced Automated NixOS Installer (ADJUSTED)
#
# Layout:
#   /boot  -> EFI FAT32
#   swap   -> Linux swap
#   /      -> ext4
#   /home  -> ext4
#
# WARNING:
#   THIS WILL COMPLETELY ERASE THE TARGET DISK.
#
# Usage:
#   sudo ./install-nixos.sh /dev/sdX hostname username
#
# Example:
#   sudo ./install-nixos.sh /dev/nvme0n1 mypc alice

set -euo pipefail

########################################
# Arguments
########################################

DISK="${1:-}"
HOSTNAME="${2:-nixos}"
USERNAME="${3:-user}"

########################################
# Partition Sizes (FIXED)
########################################

EFI_SIZE_MIB=512
SWAP_SIZE_GIB=8
ROOT_SIZE_GIB=120

EFI_START="1MiB"
EFI_END="${EFI_SIZE_MIB}MiB"

SWAP_START="$EFI_END"
SWAP_END="$((EFI_SIZE_MIB + SWAP_SIZE_GIB * 1024))MiB"

ROOT_START="$SWAP_END"
ROOT_END="$((EFI_SIZE_MIB + SWAP_SIZE_GIB * 1024 + ROOT_SIZE_GIB * 1024))MiB"

########################################
# Validation
########################################

if [[ -z "$DISK" ]]; then
    echo "Usage: sudo $0 <disk> [hostname] [username]"
    exit 1
fi

if [[ ! -b "$DISK" ]]; then
    echo "Error: $DISK is not a valid block device."
    exit 1
fi

########################################
# Info
########################################

echo "========================================="
echo "     Enhanced NixOS Installer"
echo "========================================="
echo "Disk:       $DISK"
echo "Hostname:   $HOSTNAME"
echo "Username:   $USERNAME"
echo "Swap size:  ${SWAP_SIZE_GIB}GiB"
echo "Root size:  ${ROOT_SIZE_GIB}GiB"
echo

lsblk "$DISK"

echo
read -rp "THIS WILL ERASE ALL DATA ON $DISK. Continue? (yes/no): " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
    echo "Aborted."
    exit 1
fi

########################################
# Cleanup
########################################

echo "[1/11] Unmounting old mounts..."

umount -R /mnt 2>/dev/null || true
swapoff -a 2>/dev/null || true

########################################
# Partitioning
########################################

echo "[2/11] Creating GPT partition table..."

parted -s "$DISK" mklabel gpt

# EFI
parted -s "$DISK" mkpart ESP fat32 "$EFI_START" "$EFI_END"
parted -s "$DISK" set 1 esp on

# SWAP
parted -s "$DISK" mkpart primary linux-swap "$SWAP_START" "$SWAP_END"

# ROOT
parted -s "$DISK" mkpart primary ext4 "$ROOT_START" "$ROOT_END"

# HOME
parted -s "$DISK" mkpart primary ext4 "$ROOT_END" 100%

########################################
# Refresh partition table
########################################

echo "[3/11] Reloading partition table..."

partprobe "$DISK"
udevadm settle

########################################
# Detect partition names
########################################

echo "[4/11] Detecting partition names..."

if [[ "$DISK" == *"nvme"* ]] || [[ "$DISK" == *"mmcblk"* ]]; then
    EFI_PART="${DISK}p1"
    SWAP_PART="${DISK}p2"
    ROOT_PART="${DISK}p3"
    HOME_PART="${DISK}p4"
else
    EFI_PART="${DISK}1"
    SWAP_PART="${DISK}2"
    ROOT_PART="${DISK}3"
    HOME_PART="${DISK}4"
fi

########################################
# Format filesystems
########################################

echo "[5/11] Formatting partitions..."

mkfs.fat -F32 -n EFI "$EFI_PART"
mkswap -L swap "$SWAP_PART"
mkfs.ext4 -F -L nixos "$ROOT_PART"
mkfs.ext4 -F -L home "$HOME_PART"

########################################
# Enable swap
########################################

echo "[6/11] Enabling swap..."

swapon "$SWAP_PART"

########################################
# Mount filesystems
########################################

echo "[7/11] Mounting filesystems..."

mount "$ROOT_PART" /mnt

mkdir -p /mnt/boot
mkdir -p /mnt/home

mount "$EFI_PART" /mnt/boot
mount "$HOME_PART" /mnt/home

########################################
# Generate config
########################################

echo "[8/11] Generating NixOS configuration..."

nixos-generate-config --root /mnt

########################################
# Write configuration.nix
########################################

echo "[9/11] Writing configuration.nix..."

cat > /mnt/etc/nixos/configuration.nix <<EOF
{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "$HOSTNAME";

  time.timeZone = "UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.networkmanager.enable = true;

  hardware.enableRedistributableFirmware = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  users.mutableUsers = true;

  users.users.$USERNAME = {
    isNormalUser = true;
    description = "$USERNAME";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
    initialPassword = "changeme";
  };

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    htop
    firefox
    fastfetch
    unzip
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  networking.firewall.enable = true;

  system.stateVersion = "25.05";
}
EOF

########################################
# Install NixOS
########################################

echo "[10/11] Installing NixOS..."

nixos-install

########################################
# Set root password
########################################

echo "[11/11] Set root password..."

nixos-enter --root /mnt -c 'passwd'

########################################
# Done
########################################

echo
echo "========================================="
echo "       INSTALLATION COMPLETE"
echo "========================================="
echo
echo "Disk layout:"
echo "  EFI   -> $EFI_PART mounted at /boot"
echo "  SWAP  -> $SWAP_PART"
echo "  ROOT  -> $ROOT_PART mounted at /"
echo "  HOME  -> $HOME_PART mounted at /home"
echo
echo "User:"
echo "  username: $USERNAME"
echo "  password: changeme"
echo
echo "IMPORTANT:"
echo "  Change your password after first login."
echo
echo "You can now reboot:"
echo "  reboot"
