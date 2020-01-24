<#
work on Phase 1 which includes:
--> Resetting AD Password
--> Disable AD Password
--> Reset O365 Password
--> Block O365 Sign-in
--> Disable: Exchange ActiveSync, OWA for Devices, OWA, IMAP, POP3, MAPI
--> Block any mobile device in O365
#>

#Build out the needed parameters
Write-Host "Building out the needed variables" -ForegroundColor Red
$email = Read-Host "What is the email of the user being offboarded?"
$user = $email.replace("@fulcrumtx.com","")
Write-Host "Please provide your admin account details" -ForegroundColor Red
$admuser = Get-Credential

#Reset AD Password
function Reset-ADPassword {
    Write-Host "Working on Resetting Password for"  $user
   # Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)
    Write-Host "Password for" $user "has been changed" -ForegroundColor Green
}
Reset-ADPassword
#Disable AD Password
function Disable-ADAccount {
    Write-Host "Disabling AD Account" -ForegroundColor Green
   # Disable-ADAccount -Identity $user 
    Write-Host $user"'s account has been disabled" 
}
Disable-ADAccount
#connecting to Office 365
function connect-O365 {
write-host "Connecting to Office 365"
Connect-MsolService -Credential $admuser -AzureEnvironment AzureCloud
Write-Host "Connected to Office 365 AAD" -ForegroundColor Green
}
connect-O365

#Resetting O365 password
function reset-aadPassword {
    Write-Host "Changing the password in Azure Active Directory"
    Set-MsolUserPassword -UserPrincipalName $email -ForceChangePassword
    Write-host "AAD Password has been changed" -ForegroundColor Green
}
reset-aadPassword
#block O365 log-in
<#Wuestion for Alex is what is going to be the steps to remove the user and license in AAD?
1)where would we move the de-activated account?
2)Would we just delete the user from Office 365?
#>
#terminate all active sessions

#Disable: Exchange ActiveSync, OWA for Devices, OWA, IMAP, POP3, MAPI
