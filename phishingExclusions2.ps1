# This is to add the phishing exclusions for Sophos to Office 365 tenant

# Enter username and password 
# and convert password to secure string to provide creds without prompt
Connect-exchangeonline

Start-Sleep -Seconds 1.5

# Create the override policy
New-PhishSimOverridePolicy -Name PhishSimOverridePolicy

$domains = @(
    'auditmessages.com',
    'tax-official.com',
    'apple.it-supportdesk.com',
    'it-supportdesk.com',
    'bankfraudalerts.com',
    'buildingmgmt.info',
    'corporate-realty.co',
    'court-notices.com',
    'e-billinvoices.com',
    'e-documentsign.com',
    'e-faxsent.com',
    'e-receipts.co',
    'epromodeals.com',
    'fakebookalerts.live',
    'global-hr-staff.com',
    'gmailmsg.com',
    'helpdesk-tech.com',
    'hr-benefits.site',
    'linkedn.comail-sender.online',
    'myhr-portal.site',
    'online-statements.siteoutlook-mailer.com',
    'secure-bank-alerts.cm.shipping-updates.com',
    'toll-citations.com',
    'trackshipping.online',
    'voicemailbox.online',
    'sophos-phish-threat.go-vip.co'
)

$ips = @(
    '54.240.51.52',
    '54.240.51.53'
)

# Set the override policy rules
New-PhishSimOverrideRule -Name PhishSimOverrideRule -Policy PhishSimOverridePolicy -Domains $domains -SenderIPRanges $ips

Start-Sleep -Seconds 1.5

Remove-PSSession $Session
