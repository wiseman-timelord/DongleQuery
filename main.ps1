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
            '1', '2', '3' {
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                # If a COM port is set, proceed based on the choice
                Configure-SerialPort -comPort $global:comPort
                if ($choice -eq '1') {
                    Send-BasicInfoCommands -serialPort $global:serialPort -commands $global:atCommandsBasicInfo
                } elseif ($choice -eq '2') {
                    List-ATCommands -serialPort $global:serialPort -commands $global:atCommandsList
                } elseif ($choice -eq '3') {
                    ATConsoleMode -serialPort $global:serialPort
                }
                Close-SerialPort -serialPort $global:serialPort
            }
            'P' {
                $port = Request-ComPort
                if ($port -ne $null) {
                    $global:comPort = $port
                    $global:ComNumber_9hv = $port
                } else {
                    Write-Host "Invalid COM port. Please try again."
                    Start-Sleep -Seconds 2  # Give the user time to read the message before the menu reappears.
                }
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
