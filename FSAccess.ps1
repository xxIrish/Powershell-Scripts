$sharePath = "\\Server\Share" # Replace with the path to your file share
$outputPath = "C:\AccessDetails.csv" # Replace with the desired output path

# Retrieve the Access Control List (ACL) for the file share
$acl = Get-Acl -Path $sharePath

# Create an empty array to store the access details
$accessDetails = @()

# Iterate over each access rule in the ACL
foreach ($accessRule in $acl.Access) {
    $identity = $accessRule.IdentityReference

    # Check if the identity is a user or group
    if ($identity -is [System.Security.Principal.NTAccount]) {
        $identityType = "Group"
    } else {
        $identityType = "User"
    }

    $accessRights = $accessRule.FileSystemRights
    $allowDeny = $accessRule.AccessControlType

    # Create a custom object with the access details
    $accessObject = [PSCustomObject]@{
        Identity = $identity
        Type = $identityType
        AccessRights = $accessRights
        AllowDeny = $allowDeny
    }

    # Add the access details object to the array
    $accessDetails += $accessObject
}

# Export the access details to a CSV file
$accessDetails | Export-Csv -Path $outputPath -NoTypeInformation

Write-Output "Access details exported to $outputPath."