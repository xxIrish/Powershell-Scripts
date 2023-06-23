# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# MAKE SURE TO CHANGE THE PATH TO THE UVHD YOU ARE TRYING TO DISMOUNT
# MAKE SURE TO CHANGE THE USERNAME TO THE USER YOU ARE WORKING WITH
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Dismount-DiskImage -ImagePath ""

$UPDSharePath=""
$username=""
 
#Get's User SID
$strSID = (New-Object System.Security.Principal.NTAccount($username)).Translate([System.Security.Principal.SecurityIdentifier]).value
 
#Creates UPD path String
$diskname=$UPDSharePath+"\UVHD-"+$strsid+".vhdx"
 
#Finds the disk and dismounts it
Get-DiskImage $diskname | Dismount-DiskImage