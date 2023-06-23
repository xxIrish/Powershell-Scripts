$computers = Get-Content -Path "C:\Users\tladmin\Desktop\ComputerList.txt"
$username = "CONTEXT\ayeakey"

foreach ($computer in $computers) {
    $adminGroup = [ADSI]"WinNT://$computer/Administrators"
    $user = [ADSI]"WinNT://$username"

    if ($adminGroup.Members() -notcontains $user.Path) {
        $adminGroup.Add($user.Path)
        Write-Host "Added $username to local administrators group on $computer."
    }
    else {
        Write-Host "$username is already a member of local administrators group on $computer."
    }
}