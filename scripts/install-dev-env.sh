#!/bin/bash
#
# install-dev-env.sh - install or remove the build dependencies

arch=
centos=
debian=
fedora=
[ -f /etc/os-release ] && . /etc/os-release
[ "${ID_LIKE}" == "debian" ] && debian=1
[ "${ID}" == "arch" ] && arch=1
[ "${ID}" == "centos" ] && centos=1
[ "${ID}" == "fedora" ] && fedora=1
[ "${debian}" ] || [ -f /etc/debian_version ] && debian=1

# Dependencies include:
#   build-essential libeigen3-dev libyaml-dev libfftw3-dev libavcodec-dev
#   libavformat-dev libavutil-dev libswresample-dev libsamplerate0-dev
#   libtag1-dev libchromaprint-dev python3-dev python3-numpy-dev
#   python3-numpy python3-yaml python3-six
#
# On RPM based systems like Fedora Linux, dependencies include:
#   fftw3-devel libtool automake iniparser-devel
#   SDL2-devel eigen3-devel libyaml-devel
#   ffmpeg-devel libchromaprint-devel python-devel
#   python3-devel python3-yaml python3-six

if [ "${debian}" ]
then
  PKGS="build-essential libeigen3-dev libfftw3-dev clang \
        libavcodec-dev libavformat-dev libavutil-dev libswresample-dev \
        libsamplerate0-dev libtag1-dev libchromaprint-dev \
        autotools-dev autoconf libtool fftw-dev \
        libyaml-dev python3-dev pkg-config"
  if [ "$1" == "-r" ]
  then
    sudo apt remove ${PKGS}
  else
    sudo apt install ${PKGS} pandoc zip
  fi
else
  if [ "${arch}" ]
  then
    PKGS="base-devel eigen fftw clang ffmpeg4.4 libsamplerate taglib \
          chromaprint libyaml python python-numpy python-six"
    if [ "$1" == "-r" ]
    then
      sudo pacman -Rs ${PKGS}
    else
      sudo pacman -S --needed ${PKGS} pandoc zip
    fi
  else
    have_dnf=`type -p dnf`
    if [ "${have_dnf}" ]
    then
      PINS=dnf
    else
      PINS=yum
    fi
    sudo ${PINS} makecache
    if [ "${fedora}" ]
    then
      FEDVER=`rpm -E %fedora`
      FUSION="https://download1.rpmfusion.org"
      FREE="free/fedora"
      NONFREE="nonfree/fedora"
      RELRPM="rpmfusion-free-release-${FEDVER}.noarch.rpm"
      NONRPM="rpmfusion-nonfree-release-${FEDVER}.noarch.rpm"
      PKGS="fftw3-devel libtool automake llvm-devel SDL2-devel \
            eigen3-devel libyaml-devel clang-devel libchromaprint-devel \
            python-devel python3-devel python3-yaml python3-six \
            taglib-devel libsamplerate-devel"
      if [ "$1" == "-r" ]
      then
        sudo ${PINS} -y remove compat-ffmpeg4-devel compat-ffmpeg4
        sudo ${PINS} -y remove ${PKGS}
        sudo ${PINS} -y remove gcc-c++
        sudo ${PINS} -y groupremove "Development Tools" "Development Libraries"
        sudo ${PINS} -y remove ${FUSION}/${NONFREE}/${NONRPM}
        sudo ${PINS} -y remove ${FUSION}/${FREE}/${RELRPM}
        sudo ${PINS} -y install dnf-plugins-core
        sudo ${PINS} config-manager --set-disabled rpmfusion-free
        sudo ${PINS} config-manager --set-disabled rpmfusion-free-updates
        sudo ${PINS} config-manager --set-disabled rpmfusion-nonfree-updates
        sudo ${PINS} config-manager --set-disabled rpmfusion-nonfree
        sudo ${PINS} config-manager --set-disabled rpmfusion-nonfree-nvidia-driver
        sudo ${PINS} config-manager --set-disabled rpmfusion-nonfree-steam
      else
        sudo ${PINS} -y groupinstall "Development Tools" "Development Libraries"
        sudo ${PINS} -y install gcc-c++
        sudo ${PINS} -y install ${PKGS} pandoc zip
        sudo ${PINS} -y install ${FUSION}/${FREE}/${RELRPM}
        sudo ${PINS} -y install ${FUSION}/${NONFREE}/${NONRPM}
        sudo ${PINS} -y install dnf-plugins-core
        sudo ${PINS} config-manager --set-enabled rpmfusion-free
        sudo ${PINS} config-manager --set-enabled rpmfusion-free-updates
        sudo ${PINS} config-manager --set-enabled rpmfusion-nonfree-updates
        sudo ${PINS} config-manager --set-enabled rpmfusion-nonfree
        sudo ${PINS} config-manager --set-enabled rpmfusion-nonfree-nvidia-driver
        sudo ${PINS} config-manager --set-enabled rpmfusion-nonfree-steam
        sudo ${PINS} -y update
        sudo ${PINS} -y --allowerasing install compat-ffmpeg4 \
                                               compat-ffmpeg4-devel
      fi
    else
      if [ "${centos}" ]
      then
        sudo alternatives --set python /usr/bin/python3
        CENVER=`rpm -E %centos`
        FUSION="https://download1.rpmfusion.org"
        FREE="free/el"
        NONFREE="nonfree/el"
        RELRPM="rpmfusion-free-release-${CENVER}.noarch.rpm"
        NONRPM="rpmfusion-nonfree-release-${CENVER}.noarch.rpm"
        PKGS="fftw3-devel libtool automake SDL2-devel \
              eigen3-devel libyaml-devel clang-devel \
              libchromaprint-devel python3-devel python3-yaml \
              python3-six taglib-devel libsamplerate-devel python3-numpy"
        if [ "$1" == "-r" ]
        then
          sudo ${PINS} -y remove ffmpeg-devel
          sudo ${PINS} -y remove ${PKGS}
          sudo ${PINS} -y remove gcc-c++
          sudo ${PINS} -y groupremove "Development Tools"
          sudo ${PINS} -y remove ${FUSION}/${NONFREE}/${NONRPM}
          sudo ${PINS} -y remove ${FUSION}/${FREE}/${RELRPM}
        else
          sudo ${PINS} -y groupinstall "Development Tools"
          sudo ${PINS} -y install gcc-c++
          sudo ${PINS} -y install dnf-plugins-core
          sudo ${PINS} -y install epel-release
          sudo ${PINS} config-manager --set-enabled powertools
          sudo ${PINS} -y install ${PKGS} pandoc zip
          sudo ${PINS} -y localinstall --nogpgcheck ${FUSION}/${FREE}/${RELRPM}
          sudo ${PINS} -y localinstall --nogpgcheck ${FUSION}/${NONFREE}/${NONRPM}
          sudo ${PINS} -y update
          sudo ${PINS} -y --allowerasing install ffmpeg ffmpeg-devel
        fi
      else
        echo "Unrecognized operating system"
      fi
    fi
  fi
fi
