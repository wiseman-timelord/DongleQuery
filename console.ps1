# console.ps1

# Initialization section.
function Initialize-Script {
    Clear-Host
    Write-Host "`n========================( Console Mode )========================`n"
}

# Function to request COM port number from the user.
function Request-ComPort {
    Write-Host "Please enter the COM port number (e.g., 5 for COM5): " -NoNewline
    $comPort = "COM" + (Read-Host)
    Write-Host
    return $comPort
}

# Function to configure the SerialPort object.
function Configure-SerialPort($comPort) {
    Write-Host "Configuring SerialPort object for $comPort..."
    $serialPort = New-Object System.IO.Ports.SerialPort $comPort, 9600, "None", 8, "One"
    try {
        $serialPort.Open()
        Write-Host "Serial port $comPort opened successfully."
    } catch {
        Write-Host "Failed to open serial port $comPort. Error: $_"
        exit
    }
    return $serialPort
}

# Main loop for sending AT commands and receiving responses.
function CommandLoop($serialPort) {
    do {
        $command = Read-Host "`nEnter an AT Command, or X to Exit"
        if ($command -eq "X") {
            Write-Host "Exiting..."
            break
        }
        
        $serialPort.WriteLine($command + "`r")
        Write-Host "Command sent: $command. Waiting for response..."
        Start-Sleep -Seconds 2  # Wait for the modem to respond.
        
        $response = $serialPort.ReadExisting()
        Write-Host "Response: $response"
    } while ($command -ne "X")
}

# Function to close the SerialPort connection.
function Close-SerialPort($serialPort) {
    if ($serialPort -ne $null -and $serialPort.IsOpen) {
        $serialPort.Close()
        Write-Host "SerialPort connection closed."
    }
}

# Script entry point.
Initialize-Script
$comPort = Request-ComPort
$serialPort = Configure-SerialPort $comPort
CommandLoop $serialPort
Close-SerialPort $serialPort
