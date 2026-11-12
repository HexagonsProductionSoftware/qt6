#!/usr/bin/env bash
# Copyright (C) 2026 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

set -exo pipefail

version="$1"
sha256="$2"
macosversion="$3"
internalUrl="http://ci-files01-hki.ci.qt.io/input/mac/libusb/libusb-${version}.tar.bz2"
externalUrl="https://github.com/libusb/libusb/releases/download/v${version}/libusb-${version}.tar.bz2"

source "${BASH_SOURCE%/*}/../unix/DownloadURL.sh"

export MACOSX_DEPLOYMENT_TARGET="$macosversion"
ncpu=$(sysctl -n hw.ncpu)

buildDir="/var/tmp/libusb"
mkdir -p "$buildDir"
cd "$buildDir"

DownloadURL "$internalUrl" "$externalUrl" "$sha256"
tar xjf "libusb-${version}.tar.bz2"
srcDir="$buildDir/libusb-${version}"

# Build for x86_64
mkdir -p "$buildDir/build-x86_64"
cd "$buildDir/build-x86_64"
"$srcDir/configure" --prefix=/usr/local --host=x86_64-apple-darwin \
    CFLAGS="-arch x86_64" LDFLAGS="-arch x86_64"
make -j"$ncpu"
make install DESTDIR=/tmp/libusb-x86_64

# Build for arm64
mkdir -p "$buildDir/build-arm64"
cd "$buildDir/build-arm64"
"$srcDir/configure" --prefix=/usr/local --host=aarch64-apple-darwin \
    CFLAGS="-arch arm64" LDFLAGS="-arch arm64"
make -j"$ncpu"
make install DESTDIR=/tmp/libusb-arm64

sudo "${BASH_SOURCE%/*}/makeuniversal.sh" /tmp/libusb-arm64 /tmp/libusb-x86_64

echo "libusb = $version" >> ~/versions.txt
