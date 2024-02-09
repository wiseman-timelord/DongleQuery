# utility.ps1

function Configure-SerialPort {
    param(
        [string]$comPort
    )
    $global:serialPort_4lf = New-Object System.IO.Ports.SerialPort $ComNumber_9hv, 9600, "None", 8, "One"
    try {
        $global:serialPort_4lf.Open()
        Write-Host "Port $ComNumber_9hv Opened Successfully...`n"
    }
    catch {
        Write-Host "Port Failed $ComNumber_9hv. Error: $_"
        exit
    }
}

function Close-SerialPort {
    param(
        [System.IO.Ports.SerialPort]$serialPort_4lf
    )
    if ($serialPort_4lf -ne $null -and $serialPort_4lf.IsOpen) {
        $serialPort_4lf.Close()
        Write-Host "`n...Sequence Complete, Port $ComNumber_9hv Closed."
    }
}

function Send-BasicInfoCommands {
    param(
        [System.IO.Ports.SerialPort]$serialPort_4lf,
        [string[]]$commands
    )
    foreach ($command in $commands) {
        Write-Host "Sending command: $command"
        $serialPort_4lf.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort_4lf.ReadExisting()
        Write-Host "Response: $response"
    }
}

function List-ATCommands {
    param(
        [System.IO.Ports.SerialPort]$serialPort_4lf,
        [string[]]$commands
    )
    $allResponses = @()
    foreach ($command in $commands) {
        try {
            $serialPort_4lf.WriteLine($command + "`r")
            Start-Sleep -Seconds 2
            $response = $serialPort_4lf.ReadExisting()
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
        [System.IO.Ports.SerialPort]$serialPort_4lf,
        [string]$command
    )
    try {
        $serialPort_4lf.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort_4lf.ReadExisting()
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
    $titlePart1 = $titlePart1.Trim() -replace '^OK$|^OK\s+|\s+OK$|OK\r?\n', ''
    $titlePart2 = $titlePart2.Trim() -replace '^OK$|^OK\s+|\s+OK$|OK\r?\n', ''
    $content = @()
    if (-not [string]::IsNullOrWhiteSpace($titlePart1)) { $content += $titlePart1 }
    if (-not [string]::IsNullOrWhiteSpace($titlePart2)) { $content += $titlePart2 }
    if ($content.Count -gt 0) { $content += "" }
    $content += "Complete Commands List:"
    $filteredCommands = $commands | Where-Object { $_ -ne 'OK' -and $_.Trim() -ne '' }
    $content += $filteredCommands
    Set-Content -Path $filePath -Value ($content -join "`r`n")
}


function ATConsoleMode {
    param(
        [System.IO.Ports.SerialPort]$serialPort_4lf
    )
    do {
        $command = Read-Host "Enter AT Command (or 'X' to exit)"
        if ($command -eq 'X') {
            break
        }
        $serialPort_4lf.WriteLine($command + "`r")
        Start-Sleep -Seconds 2
        $response = $serialPort_4lf.ReadExisting()
        Write-Host "Response: $response`n"
    }
    while ($true)
}
