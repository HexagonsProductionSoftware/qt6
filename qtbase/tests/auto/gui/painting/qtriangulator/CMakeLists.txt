# Copyright (C) 2026 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

# Hexagon-CHANGES: https://download.qt.io/archive/qt/6.8/CVE-2026-105923-qtbase-6.8-0001.diff

if(NOT QT_BUILD_STANDALONE_TESTS AND NOT QT_BUILDING_QT)
    cmake_minimum_required(VERSION 3.16)
    project(tst_qtriangulator LANGUAGES CXX)
    find_package(Qt6BuildInternals REQUIRED COMPONENTS STANDALONE_TEST)
endif()

#####################################################################
## tst_qtriangulator Test:
#####################################################################

qt_internal_add_test(tst_qtriangulator
    SOURCES
        tst_qtriangulator.cpp
    LIBRARIES
        Qt::Gui
        Qt::GuiPrivate
)
