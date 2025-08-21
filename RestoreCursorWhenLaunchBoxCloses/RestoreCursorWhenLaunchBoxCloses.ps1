# === CONFIGURATION ===
$appsToWatch = @("LaunchBox", "BigBox")
$checkInterval = 5  # in seconds

# === FUNCTION ===
function Restore-CursorScheme {
    $cursorKey = "HKCU:\Control Panel\Cursors"
    $scheme = "Windows Default (system scheme)"

    # Set registry key
    Set-ItemProperty -Path $cursorKey -Name Scheme -Value $scheme

    # Refresh system settings
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class NativeMethods {
        [DllImport("user32.dll", SetLastError=true)]
        public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@

    $SPI_SETCURSORS = 0x57
    $SPIF_UPDATEINIFILE = 0x01
    $SPIF_SENDCHANGE = 0x02
    [NativeMethods]::SystemParametersInfo($SPI_SETCURSORS, 0, $null, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)

    # Ask the user if they want to exit the script, reminding them it can be restarted automatically with LaunchBox/BigBox
    $exitPrompt = Read-Host "Cursor scheme restored. Press 'Y' to exit the script, or any other key to continue monitoring. If not done already, you can set this script/program to run automatically with LaunchBox/BigBox, in LB's Options/General/Startup Applications."
    if ($exitPrompt -eq 'Y') {
        Write-Output "Exiting script as per user request."
        exit
    }
    else {
        Write-Output "Continuing to monitor for LaunchBox/BigBox closure..."
    }
}

# === MAIN LOOP ===
Write-Output "Monitoring for $($appsToWatch -join ', ')..."
$wasRunning = $false

while ($true) {
    $running = Get-Process | Where-Object { $appsToWatch -contains $_.Name } | Select-Object -ExpandProperty Name

    if ($running.Count -gt 0) {
        # At least one of them is running
        $wasRunning = $true
    }
    elseif ($wasRunning) {
        # None are running *but* they were — trigger fix
        Restore-CursorScheme
        $wasRunning = $false
    }

    Start-Sleep -Seconds $checkInterval
}
