@{
    Root       = 'D:\Dropbox\~~VSC_Wrkspcs\Script_creations\RestoreCursorWhenLaunchBoxCloses\RestoreCursorWhenLaunchBoxCloses.ps1'
    OutputPath = 'D:\Dropbox\~~VSC_Wrkspcs\Script_creations\RestoreCursorWhenLaunchBoxCloses\out'
    Package    = @{
        Enabled             = $true
        Obfuscate           = $false
        HideConsoleWindow   = $false
        Name                = 'RestoreCursorWhenLaunchBoxCloses'
        Version             = '3.2.0'
        Author              = 'Wade Manns'
        Description         = 'Restores the mouse cursor scheme when LaunchBox or BigBox closes.'
        Tags                = @('LaunchBox', 'BigBox', 'Cursor', 'Restore')
        DotNetVersion       = 'v4.6.2'
        FileVersion         = '3.1.0'
        FileDescription     = ''
        ProductName         = ''
        ProductVersion      = ''
        Copyright           = ''
        RequireElevation    = $false
        ApplicationIconPath = ''
        PackageType         = 'Console'
    }
    Bundle     = @{
        Enabled = $true
        Modules = $true
        # IgnoredModules = @()
    }
}
        