$ds = New-Object System.DirectoryServices.ActiveDirectory.DirectorySearcher([adsi]"")
$ds.Filter = "(objectClass=computer)"
$ds.SearchScope = "subtree"
$ds.PropertiesToLoad.Add("msDS-DeviceIsAADJoined") | Out-Null
$computers = $ds.FindAll()

foreach ($computer in $computers) {
    $name = $computer.Properties["name"]
    $aadJoined = $computer.Properties["msDS-DeviceIsAADJoined"]

    if ($aadJoined -eq $true) {
        Write-Output "$name is Azure AD joined"
    }
    else {
        Write-Output "$name is AD joined"
    }
}