# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Hexagon-CHANGES: https://download.qt.io/archive/qt/6.8/CVE-2026-105923-qtbase-6.8-0001.diff

add_subdirectory(qpainterpath)
add_subdirectory(qpainterpathstroker)
add_subdirectory(qcolor)
add_subdirectory(qbrush)
add_subdirectory(qregion)
add_subdirectory(qpagelayout)
add_subdirectory(qpageranges)
add_subdirectory(qpagesize)
add_subdirectory(qpainter)
if (QT_FEATURE_pdf)
    add_subdirectory(qpdfwriter)
endif()
add_subdirectory(qpen)
add_subdirectory(qpaintengine)
add_subdirectory(qtransform)
add_subdirectory(qpolygon)
add_subdirectory(qtriangulator)

# QTBUG-87669
if(NOT ANDROID)
    add_subdirectory(qcolorspace)
    add_subdirectory(qcolortransform)
endif()
if(QT_FEATURE_private_tests)
    add_subdirectory(qpathclipper)
endif()
