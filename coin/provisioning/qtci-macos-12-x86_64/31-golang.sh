#!/usr/bin/env bash
#Copyright (C) 2023 The Qt Company Ltd
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

set -ex

# shellcheck source=./../unix/DownloadURL.sh
source "${BASH_SOURCE%/*}/../common/unix/DownloadURL.sh"

version="1.25.1"
urlCache="http://ci-files01-hki.ci.qt.io/input/go/macos/go$version.darwin-amd64.pkg"
urlOffcial="https://go.dev/dl/go1.25.1.darwin-amd64.pkg"
sha256="b58153a523a5b85404b713939f6cc2689ffe8a77dc5edb1019867f3227643f57"

DownloadURL $urlCache $urlOffcial $sha256 "/tmp/go-v$version.pkg"
sudo installer -pkg "/tmp/go-v$version.pkg" -target /

echo "go = $version" >> ~/versions.txt
