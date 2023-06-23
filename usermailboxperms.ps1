# Use 'Connect-ExchangeOnline' first before running

$mailboxes = Get-Mailbox -ResultSize unlimited | where{$_.RecipientTypeDetails -ne "DiscoveryMailbox"}

$output = foreach ($mailbox in $mailboxes){
    Get-MailboxPermission -Identity $mailbox.UserPrincipalName | where{$_.user -notlike "*self"}
}

Write-Output $output

$output | Export-CSV C:\temp\mailboxperms.csv