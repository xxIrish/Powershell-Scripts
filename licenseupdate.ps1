# Connect to Microsoft 365 using your admin credentials
Connect-MsolService

# Replace <user email> with the email of the user you want to check
$user = Get-MsolUser -UserPrincipalName gcallahan@cvrindy.com

# Get the licensing information for the user
$licenses = $user.Licenses

# Loop through the licenses and find the one that has the earliest activation date
$earliestActivationDate = $licenses.ServiceStatus.ProvisioningStatus
foreach ($license in $licenses) {
    $activationDate = $license.ServiceStatus.ProvisioningStatus
    if ($activationDate -lt $earliestActivationDate) {
        $earliestActivationDate = $activationDate
    }
}

# Output the activation date for the user's licenses
Write-Host "User licensed on: $earliestActivationDate"