## This is for doing it on the machine locally.

import-module activedirectory
## You can change this as needed.
$proxyaddresses = @("SMTP:user1@domain.com","SMTP:user1@domain2.com")
## This is going to pull all users in AD
$users = Get-ADUser -Filter * -Properties proxyAddresses
foreach ($user in $users) {
    $user.proxyAddresses += $proxyaddresses
    Set-ADUser $user
}