# basicinfo.ps1

# Initialization
Clear-Host

# Requesting COM port number from user
Write-Host "Requesting COM port number from user..."
$port = Read-Host "Please enter the COM port number (e.g., 5 for COM5)"

# Configuring SerialPort object for COM port
Write-Host "Configuring SerialPort object for COM$port..."
$comPort = "COM" + $port
$serialPort = new-object System.IO.Ports.SerialPort $comPort, 9600, "None", 8, "One"
try {
    $serialPort.Open()
    Write-Host "Serial port $comPort opened successfully."
} catch {
    Write-Host "Failed to open serial port $comPort. Error: $_"
    exit
}

$atCommands = @("AT", "AT+CGMI", "AT+CGMM", "AT+CGMR", "AT+CPIN?", "AT+CSQ", "AT+CREG?", "AT+COPS?", "ATI")

foreach ($atCommand in $atCommands) {
    Write-Host "Sending $atCommand to the modem on $comPort..."
    try {
        $serialPort.WriteLine($atCommand + "`r")
        Start-Sleep -Seconds 1

        # Directly attempt to read the response without looping
        $response = $serialPort.ReadExisting()
        if ($response) {
            Write-Host "Response for $($atCommand): $response"
        } else {
            Write-Host "No response received for $atCommand."
        }
    } catch {
        Write-Host "Failed to send $atCommand or read response. Error: $_"
    }
}

$serialPort.Close()
Write-Host "Closing the SerialPort connection..."
Write-Host "Process completed. Check above for modem responses and any debug information."
