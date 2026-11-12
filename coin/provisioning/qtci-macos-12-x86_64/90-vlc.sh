#!/usr/bin/env bash
#Copyright (C) 2026 The Qt Company Ltd
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

set -ex

# for QtMM streaming tests

version="3.0.23"
sha256="ec01530ce69d849dd057fba8876e68ac39bf279dc28de4e9c04e4aec11fc98db"
arch="intel64"

"${BASH_SOURCE%/*}/../common/macos/vlc_dmg_install.sh" "$version" "$sha256" "$arch"
