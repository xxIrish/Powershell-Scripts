function Stop-LibrarySync {
    param ($ProjectNumber)

    # stop OneDrive
    Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" /shutdown
    Start-Sleep -Milliseconds 500

    # remove sync configuration file
    foreach ($IniFile in (Get-Item "$env:USERPROFILE\AppData\Local\Microsoft\OneDrive\settings\Business1\ClientPolicy_*.ini")) {
        $IniFileContent = Get-Content -Path $IniFile -Encoding Unicode
        $ContainsProjectNumber = $IniFileContent | Select-String -Pattern $ProjectNumber
        if ($null -ne $ContainsProjectNumber) {
            Remove-Item $IniFile
            break
        }
    }

    # remove sync registry value
    $Key = Get-Item HKCU:\Software\Microsoft\OneDrive\Accounts\Business1\ScopeIdToMountPointPathCache
    foreach ($Property in $Key.Property) {
        if ($Key.GetValue($Property) -eq "$env:USERPROFILE\<CompanyName>\$ProjectNumber - D" ) {
            Remove-ItemProperty -Path $Key.PSPath -Name $Property
            break
        }
    }

    # remove the lines referring to this sync from the ini file
    $f = Get-Item "$env:USERPROFILE\AppData\Local\Microsoft\OneDrive\settings\Business1\????????-????-????-????-????????????*.ini"
    foreach($line in Get-Content $f -Encoding Unicode) {
        if($line -match " = \d+ ([a-f0-9+]+) .*$ProjectNumber"){
            $SyncId = $Matches[1].Replace("+", "\+")
            break
        }
    }
    Get-Content $f -Encoding Unicode | Where-Object {$_ -notmatch "$SyncId"} | Set-Content ($f.FullName + '2') -Encoding Unicode
    Remove-Item $f
    Rename-Item ($f.FullName + '2') $f.FullName

    # remove the folder
    Remove-Item "$env:USERPROFILE\<CompanyName>\$ProjectNumber - D" -Recurse -Force

    # restart OneDrive
    Start-Process "$env:LOCALAPPDATA\Microsoft\OneDrive\OneDrive.exe" /background
}