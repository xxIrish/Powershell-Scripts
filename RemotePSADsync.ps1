$DCName = "<DCName>"
$DomainAdminUsername = "<DomainAdminUsername>"
$DomainAdminPassword = "<DomainAdminPassword>"

$securePassword = ConvertTo-SecureString $DomainAdminPassword -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($DomainAdminUsername, $securePassword)

$Session = New-PSSession -ComputerName $DCName -Credential $credentials
Invoke-Command -Session $Session -ScriptBlock {Import-Module ActiveDirectory; Start-ADSyncSyncCycle -PolicyType Delta}
Remove-PSSession $Session