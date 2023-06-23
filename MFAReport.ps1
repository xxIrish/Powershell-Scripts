Connect-MsolService

$Result = @()
$users = Get-MsolUser -All

foreach ($user in $users) {
    $mfaStatus = $user.StrongAuthenticationRequirements.State 
    $methodTypes = $user.StrongAuthenticationMethods 
    
    if ($mfaStatus -ne $null -or $methodTypes -ne $null) {
        if ($mfaStatus -eq $null) { 
            $mfaStatus='Enabled (Conditional Access)'
        }
        $authMethods = $methodTypes.MethodType
        $defaultAuthMethod = ($methodTypes | Where{$_.IsDefault -eq "True"}).MethodType 
        $verifyEmail = $user.StrongAuthenticationUserDetails.Email 
        $phoneNumber = $user.StrongAuthenticationUserDetails.PhoneNumber
        $alternativePhoneNumber = $user.StrongAuthenticationUserDetails.AlternativePhoneNumber
    }
    else {
        $mfaStatus = "Disabled"
        $defaultAuthMethod = $null
        $verifyEmail = $null
        $phoneNumber = $null
        $alternativePhoneNumber = $null
    }
    
    $Result += New-Object PSObject -property @{ 
        UserName = $user.DisplayName
        UserPrincipalName = $user.UserPrincipalName
        MFAStatus = $mfaStatus
        AuthenticationMethods = $authMethods
        DefaultAuthMethod = $defaultAuthMethod
        MFAEmail = $verifyEmail
        PhoneNumber = $phoneNumber
        AlternativePhoneNumber = $alternativePhoneNumber
    }
}

$Result | Select UserName, UserPrincipalName, MFAStatus, AuthenticationMethods, DefaultAuthMethod, MFAEmail, PhoneNumber, AlternativePhoneNumber | Export-Csv -Path "C:\temp\MFA_Report.csv" -NoTypeInformation

Write-Host "MFA Report exported to C:\temp\MFA_Report.csv"