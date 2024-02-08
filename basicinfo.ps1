# Global Variables
$global:comPort_3io = $null
$global:serialPort_5fd = $null
$global:atCommands_0fn = @(
    "AT",
    "AT+CGMI",  # Manufacturer identification
    "AT+CGMM",  # Model identification
    "AT+CGMR",  # Revision identification
    "ATI"       # Device identification
)

# Initialization section
function Initialize-Script {
    Clear-Host
    Write-Host "`n========================( DongleQuery )========================`n"
}

# Finalization section.
function Finalize-Script {
    Write-Host "`nProcesses completed; Check details above, then press any key to continue...`n" -NoNewline
    $null = Read-Host
}

# Function to request COM port number from the user
function Request-ComPort {
    Write-Host "Please enter the COM port number (e.g., 5 for COM5): " -NoNewline
    $global:comPort_3io = "COM" + (Read-Host)
}

# Function to configure the SerialPort object
function Configure-SerialPort {
    Write-Host "Configuring SerialPort object for $global:comPort_3io..."
    $global:serialPort_5fd = New-Object System.IO.Ports.SerialPort $global:comPort_3io, 9600, "None", 8, "One"
    try {
        $global:serialPort_5fd.Open()
        Write-Host "Serial port $global:comPort_3io opened successfully."
    } catch {
        Write-Host "Failed to open serial port $global:comPort_3io. Error: $_"
        exit
    }
}

# Function to send AT commands to the modem
function Send-ATCommands {
    foreach ($atCommand in $global:atCommands_0fn) {
        Write-Host "Sending $atCommand to the modem on $global:comPort_3io..."
        try {
            $global:serialPort_5fd.WriteLine($atCommand + "`r")
            Write-Host "Spam prevention, waiting 2 seconds..."
            Start-Sleep -Seconds 2
            
            $response = $global:serialPort_5fd.ReadExisting()
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
    if ($global:serialPort_5fd -ne $null -and $global:serialPort_5fd.IsOpen) {
        $global:serialPort_5fd.Close()
        Write-Host "Closing the SerialPort connection..."
    }
}

# Script Entry Point
Initialize-Script
Request-ComPort
Configure-SerialPort
Send-ATCommands
Close-SerialPort
Finalize-Script
