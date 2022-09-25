Name: mpplus-essentia
Version:    %{_version}
Release:    %{_release}%{?dist}
BuildArch:  x86_64
Requires:   taglib, python3-devel, libchromaprint-devel, util-linux, libavdevice
URL:        https://github.com/doctorfree/mpplus-essentia
Vendor:     Doctorwhen's Bodacious Laboratory
Packager:   ronaldrecord@gmail.com
License     : AGPL3
Summary     : Acoustic metadata analysis and extraction

%global __os_install_post %{nil}

%description
Essentia is an audio analysis tool. It provides a reusable collection
of algorithms and descriptors mainly used to extract features from
audio files. It is written in C++, but also has Python bindings,
meaning you can control it from within Python, and write scripts that
use Essentia features (just as you would in Matlab).

This package contains command-line feature extractors based on Essentia.

%prep

%build

%install
cp -a %{_sourcedir}/usr %{buildroot}/usr

%pre

%post

%preun

%files
/usr
%exclude %dir /usr/share/doc
%exclude %dir /usr/share
%exclude %dir /usr/bin

%changelog
