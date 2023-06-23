$Machines = Get-Content -Path "C:\Users\tladmin\Desktop\ComputerList.txt" # List of machine names
$Domain = "DOMAIN" # Domain name
$Usernames = Get-Content -Path "C:\Users\tladmin\Desktop\Usernames.txt" # User account name

foreach ($Machine in $Machines) {
    $Computer = [ADSI]"WinNT://$Machine"
    $Group = $Computer.psbase.Children.Find("Administrators")

    foreach ($Username in $Usernames) {
        $User = "WinNT://$Domain/$Username"
        $Group.Members.Remove($User)
        Write-Host "Removed $Username from the Administrators group on $Machine."
    }
}
