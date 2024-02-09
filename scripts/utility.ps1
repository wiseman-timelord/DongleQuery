# utility.ps1

function Configure-SerialPort {
    param(
        [string]$comPort
    )
    $global:serialPort = New-Object System.IO.Ports.SerialPort $comPort, 9600, "None", 8, "One"
    try {
        $global:serialPort.Open()
        Write-Host "Serial port $comPort opened successfully."
    }
    catch {
        Write-Host "Failed to open serial port $comPort. Error: $_"
        exit
    }
}

function Close-SerialPort {
    param(
        [System.IO.Ports.SerialPort]$serialPort
    )
    if ($serialPort -ne $null -and $serialPort.IsOpen) {
        $serialPort.Close()
        Write-Host "Closed serial port."
    }
}

function Send-BasicInfoCommands {
    param(
        [System.IO.Ports.SerialPort]$serialPort,
        [string[]]$commands
    )
    foreach ($command in $commands) {
        Write-Host "Sending command: $command"
        $serialPort.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort.ReadExisting()
        Write-Host "Response: $response"
    }
}

function List-ATCommands {
    param(
        [System.IO.Ports.SerialPort]$serialPort,
        [string[]]$commands
    )
    foreach ($command in $commands) {
        Write-Host "Sending command: $command"
        $serialPort.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort.ReadExisting()
        Write-Host "Response: $response"
    }
}

function ATConsoleMode {
    param(
        [System.IO.Ports.SerialPort]$serialPort
    )
    do {
        $command = Read-Host "Enter AT Command (or 'X' to exit)"
        if ($command -eq 'X') {
            break
        }
        $serialPort.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort.ReadExisting()
        Write-Host "Response: $response"
    }
    while ($true)
}
