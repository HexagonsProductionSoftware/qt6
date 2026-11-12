#!/usr/bin/env bash
#Copyright (C) 2026 The Qt Company Ltd
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

set -exo pipefail

# for QtMM streaming tests
version="$1"
sha256="$2"
arch="$3"
dmg="vlc-${version}-${arch}.dmg"
internalUrl="http://ci-files01-hki.ci.qt.io/input/mac/vlc/${dmg}"
externalUrl="https://download.videolan.org/vlc/${version}/macosx/${dmg}"

source "${BASH_SOURCE%/*}/../unix/DownloadURL.sh"

tmpDir="/var/tmp/vlc"
mkdir -p "$tmpDir"
cd "$tmpDir"

DownloadURL "$internalUrl" "$externalUrl" "$sha256" "$dmg"

hdiutil attach "$dmg" -mountpoint /Volumes/VLC -nobrowse -quiet
trap 'hdiutil detach /Volumes/VLC -quiet 2>/dev/null || true' EXIT
sudo cp -r "/Volumes/VLC/VLC.app" /Applications/
hdiutil detach /Volumes/VLC -quiet
trap - EXIT

echo "VLC = $version" >> ~/versions.txt
