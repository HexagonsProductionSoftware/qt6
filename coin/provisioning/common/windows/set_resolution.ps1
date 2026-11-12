# Copyright (C) 2026 The Qt Company Ltd
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

. "$PSScriptRoot\helpers.ps1"
$cpu_arch = Get-CpuArchitecture

switch ($cpu_arch) {
    arm64 {
        $x_value = 1280
        $y_value = 1024
        Break
    }
    x64 {
        $x_value = 1280
        $y_value = 800
    }
    default {
        throw "Unknown architecture $cpu_arch"
    }
}

$baseKey = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers\Configuration"

if (-not (Test-Path $baseKey)) {
    Write-Host "GraphicsDrivers configuration path not found."
    exit 0
}

function Set-Value($path, $name, $value) {
    if (Test-Path $path) {
        New-ItemProperty -Path $path -Name $name -Value $value -PropertyType DWord -Force | Out-Null
    }
}

$cfgKeys = Get-ChildItem -Path $baseKey

foreach ($cfg in $cfgKeys) {
    $k00    = Join-Path $cfg.PSPath "00"
    $k0000  = Join-Path $k00 "00"

    $targets = @()
    if (Test-Path $k00)   { $targets += $k00 }
    if (Test-Path $k0000) { $targets += $k0000 }

    foreach ($t in $targets) {
        Write-Host "Updating resolution keys in: $t"

        Set-Value $t "ActiveSize.cx" $x_value
        Set-Value $t "ActiveSize.cy" $y_value

        Set-Value $t "PrimSurfSize.cx" $x_value
        Set-Value $t "PrimSurfSize.cy" $y_value

        Set-Value $t "DwmClipBox.right"  $x_value
        Set-Value $t "DwmClipBox.bottom" $y_value
    }
}

Write-Host "Resolution registry update complete (set to $x_value x $y_value)."
Write-Host "A reboot is required for changes to apply."
