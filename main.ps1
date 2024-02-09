# main.ps1

# Load external scripts
. .\scripts\display.ps1
. .\scripts\utility.ps1

# Global Variables
$global:comPort = $null
$global:serialPort = $null
$global:ComNumber_9hv = 'None'  # Corrected global variable declaration
# Consolidating AT commands into a single variable, considering both sets for different functionalities
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
                Configure-SerialPort -comPort $global:comPort
                Send-BasicInfoCommands -serialPort $global:serialPort -commands $global:atCommandsBasicInfo
                Close-SerialPort -serialPort $global:serialPort
            }
            '3' {  # List AT Commands
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
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
                Write-Host "Exiting program..."
                break
            }
        }
    }
}


# Invoke Main Function
Main
