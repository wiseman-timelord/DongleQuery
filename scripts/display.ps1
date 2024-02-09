# display.ps1

function Show-Menu {
    param (
        [string]$ComNumber_9hv
    )
    Clear-Host
    Write-Host ""
	Write-Host "========================( DongleQuery )========================"
	Write-Host "`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n"
    Write-Host "                        1. Set COM Port"
    $comDisplay = if ($ComNumber_9hv) { $ComNumber_9hv } else { "None" }
    Write-Host "                            ($comDisplay)`n"
    Write-Host "                     2. Basic Dongle Info`n`n"
    Write-Host "                      3. List AT Commands`n`n"
    Write-Host "                      4. AT Console Mode`n`n"
    Write-Host "`n`n`n`n`n`n`n`n`n`n`n`n`n`n`n"
}

function Get-MenuChoice {
    $choice = $null
    while ($null -eq $choice) {
        $choice = Read-Host "Select, Options = 1-4, Exit = X: "
        if (-not ('1', '2', '3', '4', 'X' -contains $choice.ToUpper())) {
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
