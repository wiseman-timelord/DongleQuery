# main.ps1

# Load external scripts
. .\scripts\display.ps1
. .\scripts\utility.ps1
. .\scripts\impexppsd1.ps1

# Global Variables
$settingsPath = ".\settings.psd1"
$ConfigData = Import-PowerShellData1 -Path $settingsPath
$global:ComNumber_9hv = $ConfigData.ComPort
$global:comPort = if ($global:ComNumber_9hv -ne 'None') { $global:ComNumber_9hv } else { $null }
$global:serialPort = $null

# Variable Lists
$global:atCommandsBasicInfo = @(
    "AT",
    "AT+CGMI",  # Manufacturer identification
    "AT+CGMM",  # Model Information
    "AT+CGMR",  # Revision identification
    "ATI"       # Device identification
)
$global:atCommandsList = @(
    "AT",
    "AT+CLAC"  # List Commands
)

function Main {
    while ($true) {
        Show-Menu -ComNumber_9hv $global:ComNumber_9hv
        $choice = Get-MenuChoice
        switch ($choice) {
            '1' {  # Set COM Port
                $port = Request-ComPort
                if ($port -ne $null) {
                    $global:comPort = $port
                    $global:ComNumber_9hv = $port
                    # Save updated setting to PSD1 file
                    $ConfigData.ComPort = $port
                    Export-PowerShellData1 -Data $ConfigData -Path $settingsPath
                } else {
                    Write-Host "Invalid COM port. Please try again."
                    Start-Sleep -Seconds 2
                }
            }

            '2' {  # Basic Dongle Info
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                Clear-Host
				Display-PageTitle
				Configure-SerialPort -comPort $global:comPort
                Send-BasicInfoCommands -serialPort $global:serialPort -commands $global:atCommandsBasicInfo
                Close-SerialPort -serialPort $global:serialPort
				Write-Host "`nBasic Info Retrieved, Press Any Key to continue...`n" -NoNewline
   			    [Console]::ReadKey($true) | Out-Null
            }
            '3' {  # List AT Commands
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                Clear-Host
				Display-PageTitle
				Configure-SerialPort -comPort $global:comPort
                List-ATCommands -serialPort $global:serialPort -commands $global:atCommandsList
                Close-SerialPort -serialPort $global:serialPort
            }
            '4' {  # AT Console Mode
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                Configure-SerialPort -comPort $global:comPort
                ATConsoleMode -serialPort $global:serialPort
                Close-SerialPort -serialPort $global:serialPort
            }
            'X' {
                Display-CompletionMessage
                break
            }
        }
    }
}


# Invoke Main Function
Display-InitializationMessage
Main
