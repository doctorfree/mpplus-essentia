[Essentia](https://essentia.upf.edu/index.html) is an open-source C++ library for audio analysis and audio-based music information retrieval. It contains an extensive collection of algorithms, including audio input/output functionality, standard digital signal processing blocks, statistical characterization of data, a large variety of spectral, temporal, tonal, and high-level music descriptors, and tools for inference with deep learning models.

**[Important Note:]** This release of the `mpplus-essentia` package is intended to serve as a release for integration with `MusicPlayerPlus`.

This release of mpplus-essentia adds support for:

* Installation as a separate standalone package on multiple platforms
* Create packaging for Arch Linux, CentOS, Fedora, Ubuntu, and Raspberry Pi OS
* Integrated features and customizations from MusicPlayerPlus
* Add pre-trained support vector machine (SVM) models to release packages

## Installation

Download the [latest Debian, Arch, or RPM package format release](https://github.com/doctorfree/mpplus-essentia/releases) for your platform.

Install the package on Debian based systems by executing the command:

```bash
sudo apt install ./mpplus-essentia_1.0.2-1.amd64.deb
```

or, on a Raspberry Pi:

```bash
sudo apt install ./mpplus-essentia_1.0.2-1.armhf.deb
```

Install the package on Arch Linux based systems by executing the command:

```bash
sudo pacman -U ./mpplus-essentia_1.0.2-1-x86_64.pkg.tar.zst
```

Install the package on RPM based systems by executing one of the following commands.

On Fedora Linux:

```bash
sudo yum localinstall ./mpplus-essentia_1.0.2-1.fc36.x86_64.rpm
```

On CentOS Linux:

```bash
sudo yum localinstall ./mpplus-essentia_1.0.2-1.el8.x86_64.rpm
```

### PKGBUILD Installation

To install on a Raspberry Pi running Arch Linux, mpplus-essentia must be built from sources using the Arch PKGBUILD files provided in `mpplus-essentia-pkgbuild-1.0.2-1.tar.gz`. This process can be performed on any `x86_64` or `armv7h ` architecture system running Arch Linux. An `x86_64` architecture precompiled package is supplied (see above). To rebuild this package from sources, extract `mpplus-essentia-pkgbuild-1.0.2-1.tar.gz` and use the `makepkg` command to download the sources, build the binaries, and create the installation package:

```
tar xzf mpplus-essentia-pkgbuild-1.0.2-1.tar.gz
cd mpplus-essentia
makepkg --force --log --cleanbuild --noconfirm --syncdeps
```

## Removal

Removal of the package on Debian based systems can be accomplished by issuing the command:

```bash
sudo apt remove mpplus-essentia
```

Removal of the package on RPM based systems can be accomplished by issuing the command:

```bash
sudo yum remove mpplus-essentia
```

Removal of the package on Arch Linux based systems can be accomplished by issuing the command:

```bash
sudo pacman -Rs mpplus-essentia
```

## Building mpplus-essentia from source

mpplus-essentia can be compiled, packaged, and installed from the source code repository. This should be done as a normal user with `sudo` privileges:

```
# Retrieve the source code from the repository
git clone https://github.com/doctorfree/mpplus-essentia.git
# Enter the mpplus-essentia source directory
cd mpplus-essentia
# Install the necessary build environment (not necessary on Arch Linux)
scripts/install-dev-env.sh
# Compile mpplus-essentia and create an installation package
./mkpkg
# Install mpplus-essentia and its dependencies
./Install
```

The `mkpkg` script detects the platform and creates an installable package in the package format native to that platform. After successfully building mpplus-essentia, the resulting installable package will be found in the `./releases/<version>/` directory.

## Changelog

Changes in version 1.0.2 release 1 include:

* New algorithms for onset detection, beat tracking and melody extraction
* New and updated features extractors

Changes in version 1.0.1 release 2 include:

* Support for Arch-like systems (e.g. Manjaro Linux)

Changes in version 1.0.1 release 1 include:

* Installation as a separate standalone package on multiple platforms
* Integrated features and customizations from MusicPlayerPlus
* Create packaging for Arch Linux, CentOS, Fedora, Ubuntu, and Raspberry Pi OS
* Inclusion of support vector machine (SVM) models

See [Changelog](https://github.com/doctorfree/mpplus-essentia/blob/master/Changelog) for a full list of changes in every mpplus-essentia release
