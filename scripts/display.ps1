# display.ps1

function Show-Menu {
    param (
        [string]$ComNumber_9hv
    )
    Clear-Host
    Write-Host "`n========================( DongleQuery )========================`n"
    $comDisplay = if ($ComNumber_9hv) { $ComNumber_9hv } else { "None" }
    Write-Host "                            COM: $comDisplay"
    Write-Host "1. Basic Dongle Info"
    Write-Host "2. List AT Commands"
    Write-Host "3. AT Console Mode"
    Write-Host "P. Set COM Port"
    Write-Host "X. Exit"
    Write-Host
}

function Get-MenuChoice {
    $choice = $null
    while ($null -eq $choice) {
        $choice = Read-Host "Select, Options = 1-3, Set Port = P, Exit = X: "
        if (-not ('1', '2', '3', 'P', 'X' -contains $choice.ToUpper())) {
            Write-Host "Invalid option, please try again."
            $choice = $null
        }
    }
    return $choice.ToUpper()
}

function Request-ComPort {
    Write-Host "Please enter the COM port number (e.g., 5 for COM5): " -NoNewline
    $comPort = Read-Host
    if ($comPort -match "^\d+$") { # Ensure input is numeric
        Write-Host "Selected COM port: COM$comPort"
        return "COM$comPort"
    } else {
        Write-Host "Invalid COM port number. Please ensure you enter a numeric value."
        return $null
    }
}

# Function to display initialization and completion messages for each action
function Display-InitializationMessage {
    param (
        [string]$message
    )
    Write-Host "`n$message`n" -ForegroundColor Cyan
}

function Display-CompletionMessage {
    param (
        [string]$message
    )
    Write-Host "`n$message Press any key to continue..." -ForegroundColor Green
    $null = Read-Host
}
