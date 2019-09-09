#Get-GetActiveWindow
$code = @'
    [DllImport("user32.dll")]
     public static extern IntPtr GetForegroundWindow();
'@
$NonInteractiveDefaultProcesses = @(
    'ApplicationFrameHost',
    'backgroundTaskHost'
    'CodeHelper',
    'CompPkgSrv',
    'ctfmon',
    'dllhost',
    'Docker',
    'dptf_helper',
    'FileCoAuth',
    'gpg-agent',
    'OneDrive',
    'ONENOTEM',
    'RemindersServer',
    'RuntimeBroker',
    'SCNotification'
    'SearchUI',
    'SearchProtocolHost',
    'SettingSyncHost',
    'SecurityHealthSystray',
    'ShellExperienceHost',
    'sihost',
    'SkypeApp',
    'SkypeBackgroundHost',
    'SkypeBridge',
    'smartscreen',
    'SpeechRuntime',
    'StartMenuExperienceHost',
    'SurfaceDTX', 
    'SystemSettingsBroker',
    'svchost', 
    'TabTip',
    'taskhostw', 
    'vsls-agent'
    'WindowsInternal.ComposableShell.Experiences.TextInput.InputApp',
    'WinStore.App',
    'YourPhone'
    )

Add-Type $code -Name Utils -Namespace Win32
$csvPath = "C:\tracker\$(Get-Date -Format dd-MM-yy)-ActiveWindow.csv"

while (1) {
        
    $hwnd = [Win32.Utils]::GetForegroundWindow()
    Get-Process -IncludeUserName | 
    Where-Object { ($_.mainWindowHandle -eq $hwnd) -and ($_.userName -match $env:USERNAME) -and ($_.ProcessName -notin $NonInteractiveDefaultProcesses) } | 
    Select-Object processName, MainWindowTitle, MainWindowHandle, @{name = 'CurrentTime' ; expression = { [datetime]::Now.ToLongTimeString() } }, @{name = 'CurrentDate' ; expression = { [datetime]::Now.ToShortDateString() } } |  
    Export-Csv -Path $csvPath -Append
    Start-Sleep -Seconds 1
} 
