# main.ps1

# Load external scripts
. .\scripts\display.ps1
. .\scripts\utility.ps1
. .\scripts\impexppsd1.ps1

# Global Variables
$settingsPath = ".\settings.psd1"
$ConfigData = Import-PowerShellData1 -Path $settingsPath
$global:ComNumber_9hv = if ($ConfigData.ComPort -ne 'None') { $ConfigData.ComPort } else { $null }
$global:serialPort_4lf = $null

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
			'1' {
				$port = Request-ComPort
				if ($port -ne $null) {
					$global:ComNumber_9hv = $port
					$ConfigData.ComPort = $port
					Export-PowerShellData1 -Data $ConfigData -Path $settingsPath -Name
				} else {
					Write-Host "Invalid Port, Try Again!"
					Start-Sleep -Seconds 2
				}
			}
            '2' {
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                Clear-Host
				Display-PageTitle
				Configure-SerialPort -ComNumber_9hv $global:ComNumber_9hv
                Send-BasicInfoCommands -serialPort_4lf $global:serialPort_4lf -commands $global:atCommandsBasicInfo
                Close-SerialPort -serialPort_4lf $global:serialPort_4lf
				Write-Host "`nRetrieved; Check Display, Then Press Any Key...`n" -NoNewline
   			    [Console]::ReadKey($true) | Out-Null
            }
			'3' {
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
				Clear-Host
				Display-PageTitle
				Configure-SerialPort -ComNumber_9hv $global:ComNumber_9hv
				Write-Host "Setting Up CommandsList.Txt List File.."
				$titlePart1 = Send-CommandAndGetResponse -serialPort_4lf $global:serialPort_4lf -command "AT+CGMI"
				$titlePart2 = Send-CommandAndGetResponse -serialPort_4lf $global:serialPort_4lf -command "AT+CGMR"
				if ($titlePart1 -eq $null -or $titlePart2 -eq $null) {
					Write-Host "..Error Retrieving Basics"
				} else {
					Write-Host "..CommandsList.Txt Basics Retrieved.`n"
					Write-Host "Requesting Commands From Dongle.."
					$commandsOutput = List-ATCommands -serialPort_4lf $global:serialPort_4lf -commands $global:atCommandsList
					$filePath = "CommandsList.Txt"
					$title = "$titlePart1 - $titlePart2"
					Export-CommandsToFile -filePath $filePath -titlePart1 $titlePart1 -titlePart2 $titlePart2 -commands $commandsOutput
					Write-Host "..Retrieved, Saved: $filePath"
				}
				Close-SerialPort -serialPort_4lf $global:serialPort_4lf
				Write-Host "`nCreated; Open CommandsList.Txt, Then Press Any Key...`n" -NoNewline
				[Console]::ReadKey($true) | Out-Null
			}
            '4' {
			    Clear-Host
				Display-PageTitle
                if ($global:ComNumber_9hv -eq 'None') {
                    Write-Host "Port Not Set!"
                    Start-Sleep -Seconds 2
                    continue
                }
                Configure-SerialPort -ComNumber_9hv $global:ComNumber_9hv
                ATConsoleMode -serialPort_4lf $global:serialPort_4lf
                Close-SerialPort -serialPort_4lf $global:serialPort_4lf
            }
            'X' {
                Display-CompletionMessage
                return # This line ensures that the function exits here.
            }
        }
    }
}

# Invoke Main Function
Display-InitializationMessage
Main
