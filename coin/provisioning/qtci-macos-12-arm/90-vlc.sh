#!/usr/bin/env bash
#Copyright (C) 2026 The Qt Company Ltd
#SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

set -ex

# for QtMM streaming tests

version="3.0.23"
sha256="fc6fac08d87f538517d44aca0c5e7a244b67c8c4cb589bf478363a7315fd5e0d"
arch="arm64"

"${BASH_SOURCE%/*}/../common/macos/vlc_dmg_install.sh" "$version" "$sha256" "$arch"
