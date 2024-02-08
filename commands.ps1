# commands.ps1

# Initialization
Clear-Host
Write-Host "`n========================( DongleQuery )========================`n"

# List of AT commands the modem
$atCommands = @(
    "AT",           # Test AT command ready
    "AT+CLAC",      # List all available AT commands (may not be supported by all modems)
)

# Opening serial port, as already defined in basic script

foreach ($atCommand in $atCommands) {
    Write-Host "Sending $atCommand to the modem on $comPort..."
    try {
        $serialPort.WriteLine($atCommand + "`r")
        Start-Sleep -Seconds 1

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
