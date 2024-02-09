# commands.ps1

# Global Variables
$global:comPort_9iv = $null
$global:serialPort_8ev = $null
$global:atCommands_2vn = @(
    "AT",
    "AT+CLAC"  # List Commands
)

# Initialization section.
function Initialize-Script {
    Clear-Host
    Write-Host "`n========================( DongleQuery )========================`n"
}

# Finalization section.
function Finalize-Script {
    Write-Host "`nProcesses completed; Check details above, then Press any key...`n" -NoNewline
    $null = Read-Host
}

# Function to request COM port number from the user
function Request-ComPort {
    Write-Host "Please enter the COM port number (e.g., 5 for COM5): " -NoNewline
    $global:comPort_9iv = "COM" + (Read-Host)
	Write-Host
}

# Function to configure the SerialPort object
function Configure-SerialPort {
    Write-Host "Configuring SerialPort object for $global:comPort_9iv..."
    $global:serialPort_8ev = New-Object System.IO.Ports.SerialPort $global:comPort_9iv, 9600, "None", 8, "One"
    try {
        $global:serialPort_8ev.Open()
        Write-Host "Serial port $global:comPort_9iv opened successfully."
    } catch {
        Write-Host "Failed to open serial port $global:comPort_9iv. Error: $_"
        exit
    }
	Write-Host
}

# Function to send AT commands to the modem
function Send-ATCommands {
    foreach ($atCommand in $global:atCommands_2vn) {
        Write-Host "Sending $atCommand to the modem on $global:comPort_9iv..."
        try {
            $global:serialPort_8ev.WriteLine($atCommand + "`r")
            Write-Host "Spam prevention, waiting 2 seconds..."
            Start-Sleep -Seconds 2
            
            $response = $global:serialPort_8ev.ReadExisting()
            if ($response) {
                Write-Host "Response for $($atCommand): $response"  # Corrected line here
            } else {
                Write-Host "No response received for $atCommand."
            }
        } catch {
            Write-Host "Failed to send $atCommand or read response. Error: $_"
        }
    }
}

# Function to close the SerialPort connection
function Close-SerialPort {
    if ($global:serialPort_8ev -ne $null -and $global:serialPort_8ev.IsOpen) {
        $global:serialPort_8ev.Close()
        Write-Host "Closing the SerialPort connection..."
    }
}

# Script Entry Point.
Initialize-Script
Request-ComPort
Configure-SerialPort
Send-ATCommands
Close-SerialPort
Finalize-Script
