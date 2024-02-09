# utility.ps1

function Configure-SerialPort {
    param(
        [string]$comPort
    )
    $global:serialPort = New-Object System.IO.Ports.SerialPort $comPort, 9600, "None", 8, "One"
    try {
        $global:serialPort.Open()
        Write-Host "Port $comPort Opened Successfully...`n"
    }
    catch {
        Write-Host "Port Failed $comPort. Error: $_"
        exit
    }
}

function Close-SerialPort {
    param(
        [System.IO.Ports.SerialPort]$serialPort
    )
    if ($serialPort -ne $null -and $serialPort.IsOpen) {
        $serialPort.Close()
        Write-Host "`n...Sequence Complete, Port $comPort Closed."
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
    $allResponses = @()
    foreach ($command in $commands) {
        try {
            $serialPort.WriteLine($command + "`r")
            Start-Sleep -Seconds 2
            $response = $serialPort.ReadExisting()
            $responses = $response -split "`r?`n"
            $allResponses += $responses
        }
        catch {
            Write-Host "Error sending command: $command"
        }
    }
    return $allResponses
}

function Send-CommandAndGetResponse {
    param(
        [System.IO.Ports.SerialPort]$serialPort,
        [string]$command
    )
    try {
        $serialPort.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort.ReadExisting()
        return $response.Trim()
    }
    catch {
        Write-Host "Error sending command: $command"
        return $null
    }
}

function Export-CommandsToFile {
    param(
        [string]$filePath,
        [string]$titlePart1,
        [string]$titlePart2,
        [string[]]$commands
    )

    # Trim the title parts to remove any leading/trailing whitespace and 'OK'
    $titlePart1 = $titlePart1.Trim() -replace '^OK$|^OK\s+|\s+OK$|OK\r?\n', ''
    $titlePart2 = $titlePart2.Trim() -replace '^OK$|^OK\s+|\s+OK$|OK\r?\n', ''

    # Initialize content array; add title parts if not empty
    $content = @()
    if (-not [string]::IsNullOrWhiteSpace($titlePart1)) { $content += $titlePart1 }
    if (-not [string]::IsNullOrWhiteSpace($titlePart2)) { $content += $titlePart2 }

    # Ensure separation between title and commands list
    if ($content.Count -gt 0) { $content += "" } # Add a blank line only if there's a title

    # Add the "Complete Commands List:" heading
    $content += "Complete Commands List:"

    # Append commands, filtering out 'OK' and empty lines
    $filteredCommands = $commands | Where-Object { $_ -ne 'OK' -and $_.Trim() -ne '' }
    $content += $filteredCommands

    # Write the assembled content to the specified file
    Set-Content -Path $filePath -Value ($content -join "`r`n")
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
