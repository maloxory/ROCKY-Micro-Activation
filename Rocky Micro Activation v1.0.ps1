<#
    Title: ROCKY Micro Activation v1.0
    Copyright© 2024 ROCKY. All rights reserved.
    Contact: No Way!
#>

# Check if the script is running with administrator privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch the script with administrator privileges
    Start-Process powershell -Verb RunAs -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    exit
}

# Function to center text
function CenterText {
    param (
        [string]$text,
        [int]$width
    )
    
    $textLength = $text.Length
    $padding = ($width - $textLength) / 2
    return (" " * [math]::Max([math]::Ceiling($padding), 0)) + $text + (" " * [math]::Max([math]::Floor($padding), 0))
}

# Function to create a border
function CreateBorder {
    param (
        [string[]]$lines,
        [int]$width
    )

    $borderLine = "+" + ("-" * $width) + "+"
    $borderedText = @($borderLine)
    foreach ($line in $lines) {
        $borderedText += "|$(CenterText $line $width)|"
    }
    $borderedText += $borderLine
    return $borderedText -join "`n"
}

# Display script information with border
$title = "ROCKY Micro Activation v1.0"
$copyright = "Copyright 2024 ROCKY. All rights reserved."
$contact = "Contact: No way!"
$maxWidth = 60

$infoText = @($title, $copyright, $contact)
$borderedInfo = CreateBorder -lines $infoText -width $maxWidth

Write-Host $borderedInfo -ForegroundColor Cyan

Write-Host "Please choose an option:"
Write-Host "1 - Activate Windows Permanently"
Write-Host "2 - Activate Office Permanently"
Write-Host "3 - Activate Windows & Office Permanently"
Write-Host ""
Write-Host "Note: Ensure you are connected to the internet while activating." -ForegroundColor Yellow
Write-Host ""
$choice = Read-Host "Enter your choice (1, 2, or 3)"

switch ($choice) {
    1 {
        Write-Host "Activating Windows Permanently..."
        & ([ScriptBlock]::Create((irm https://get.activated.win))) /HWID
    }
    2 {
        Write-Host "Activating Office Permanently..."
        & ([ScriptBlock]::Create((irm https://get.activated.win))) /Ohook
    }
    3 {
        Write-Host "Activating Windows & Office Permanently..."
        & ([ScriptBlock]::Create((irm https://get.activated.win))) /HWID /Ohook
    }
    default {
        Write-Host "Invalid selection. Please enter 1, 2, or 3."
    }
}

Write-Host "Activation process complete."

pause