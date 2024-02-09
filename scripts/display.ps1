# display.ps1

function Show-Menu {
    param (
        [string]$ComNumber_9hv
    )
    Clear-Host
    Write-Host ""
	Write-Host "========================( DongleQuery )========================"
	Write-Host "`n`n`n`n`n`n`n`n`n`n`n`n`n`n"
    Write-Host "                     1. Set COM Port Used"
    $comDisplay = if ($ComNumber_9hv) { $ComNumber_9hv } else { "None" }
    Write-Host "                            ($comDisplay)`n"
    Write-Host "                  2. Display Basic Device Info`n`n"
    Write-Host "                  3. Create CommandsList.Txt`n`n"
    Write-Host "                    4. AT Console Interface`n`n"
    Write-Host "`n`n`n`n`n`n`n`n`n`n`n`n`n`n"
	Write-Host "---------------------------------------------------------------"
}

function Get-MenuChoice {
    $choice = $null
    while ($null -eq $choice) {
        $choice = Read-Host "Select; Options = 1-4, Exit = X"
        if (-not ('1', '2', '3', '4', 'X' -contains $choice.ToUpper())) {
            Write-Host "Invalid Choice, Try Again!"
            $choice = $null
        }
    }
    return $choice.ToUpper()
}

function Request-ComPort {
    Write-Host "Enter COM Port Number (e.g., 3 for COM3): " -NoNewline
    $comPort = Read-Host
    if ($comPort -match "^\d+$") { # Ensure input is numeric
        Write-Host "Selected COM port: COM$comPort"
        return "COM$comPort"
    } else {
        Write-Host "Invalid Choice, Try Again!"
        return $null
    }
}

# Function to display initialization and completion messages for each action
function Display-InitializationMessage {
    [Console]::ForegroundColor = [ConsoleColor]::White
    [Console]::BackgroundColor = [ConsoleColor]::DarkGray
    [Console]::Clear() 
    Display-PageTitle
	Write-Host "Powershell Script Initialized...`n"
	Start-Sleep -Seconds 2
}

# Function to display initialization and completion messages for each action
function Display-PageTitle {
    Write-Host "`n========================( DongleQuery )========================`n"
}

function Display-CompletionMessage {
    Write-Host "`nExiting Powershell Script...`n"
	Start-Sleep -Seconds 2
}
