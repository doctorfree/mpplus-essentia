# Arch Linux AUR packaging

This directory contains the packaging files for the Arch User Repository.
See https://wiki.archlinux.org/title/Arch_User_Repository

## Requirements

The essentia build on Arch Linux requires `libgaia2` from the AUR.
Install required dependencies as follows:

```shell
git clone https://aur.archlinux.org/libgaia2.git
cd libgaia2
makepkg
sudo pacman -U libgaia2-<version>-<release>-<architecture>.pkg.tar.zst
```

## Build and Install

To build on Arch Linux, in this directory issue the command:

```shell
makepkg
```

After successfully building, to install:

```shell
sudo pacman -U essentia-extractor-<version>-<release>-<architecture>.pkg.tar.zst
```

If dependencies are not met the installation will report missing packages.
These dependent packages must first be installed and the `essentia-extractor`
package install with `pacman` repeated.

To uninstall:

```shell
sudo pacman -R essentia-extractor
```
