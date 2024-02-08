# Global Variables
$global:comPort = $null
$global:serialPort = $null
$global:atCommands = @(
    "AT",
    "AT+CGMI",  # Manufacturer identification
    "AT+CGMM",  # Model identification
    "AT+CGMR",  # Revision identification
    "AT+CPIN?", # SIM PIN status
    "ATI"       # Device identification
)

# Initialization section
function Initialize-Script {
    Clear-Host
    Write-Host "`n========================( DongleQuery )========================`n"
}

# Function to request COM port number from the user
function Request-ComPort {
    Write-Host "Please enter the COM port number (e.g., 5 for COM5):"
    $global:comPort = "COM" + (Read-Host)
}

# Function to configure the SerialPort object
function Configure-SerialPort {
    Write-Host "Configuring SerialPort object for $global:comPort..."
    $global:serialPort = New-Object System.IO.Ports.SerialPort $global:comPort, 9600, "None", 8, "One"
    try {
        $global:serialPort.Open()
        Write-Host "Serial port $global:comPort opened successfully."
    } catch {
        Write-Host "Failed to open serial port $global:comPort. Error: $_"
        exit
    }
}

# Function to send AT commands to the modem
function Send-ATCommands {
    foreach ($atCommand in $global:atCommands) {
        Write-Host "Sending $atCommand to the modem on $global:comPort..."
        try {
            $global:serialPort.WriteLine($atCommand + "`r")
            Write-Host "Spam prevention, waiting 2 seconds..."
            Start-Sleep -Seconds 2
            
            $response = $global:serialPort.ReadExisting()
            if ($response) {
                Write-Host "Response for $($atCommand): $response"
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
    if ($global:serialPort -ne $null -and $global:serialPort.IsOpen) {
        $global:serialPort.Close()
        Write-Host "Closing the SerialPort connection..."
    }
}

# Finalization section
function Finalize-Script {
    Write-Host "`nProcesses completed. Check above for port response information.`n"
    Start-Sleep -Seconds 5
}

# Script Entry Point
Initialize-Script
Request-ComPort
Configure-SerialPort
Send-ATCommands
Close-SerialPort
Finalize-Script
