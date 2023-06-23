# Connect to Microsoft 365 using your admin credentials
Connect-MicrosoftTeams

# Replace <user email> with the email of the user you want to check
$user = Get-MsolUser -UserPrincipalName "gcallahan@cvrindy.com"

# Get license details for the user
$licenseDetails = Get-MsolUserLicenseDetail -ObjectId $user.ObjectId

# Create a custom object to hold the license details
$licenseInfo = [PSCustomObject]@{
    UserPrincipalName = $user.UserPrincipalName
    Licenses = $licenseDetails.Licenses.AccountSkuId -join ";"
    LicenseStatus = $licenseDetails.Licenses.ServiceStatus -join ";"
    AssignedTimestamp = $licenseDetails.Licenses.AssignedTimestamp -join ";"
    ExpirationDate = $licenseDetails.Licenses.SkuPartNumber | ForEach-Object {
        $license = Get-MsolAccountSku | Where-Object {$_.AccountSkuId -eq $_} | Select-Object -ExpandProperty ServiceStatus
        if ($license.ObjectState -eq "Disabled") {
            "N/A"
        } else {
            $license.ActiveUnits | ForEach-Object {
                $_.WarningThresholdDate.ToShortDateString()
            }
        }
    } -join ";"
}

# Export the license details to a CSV file
$licenseInfo | Export-Csv -Path "C:\Temp\UserLicenseInfo.csv" -NoTypeInformation
