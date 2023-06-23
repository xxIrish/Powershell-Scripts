Connect-ExchangeOnline


# Replace "C:\Path\to\file.csv" with the actual path to your CSV file
$users = Import-Csv -Path "C:\Users\awilson\Documents\CVRGAL.csv"

# Hide users from GAL
$users | ForEach-Object {
    $user = $_.User
    Set-Mailbox -Identity $user -HiddenFromAddressListsEnabled $true
    Write-Host "Hidden from GAL: $user" -ForegroundColor Green
}