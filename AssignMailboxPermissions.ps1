## Terrell Bryant 05/23/2023 ##
Connect-ExchangeOnline -UserPrincipalName terrell.bryant@piscesworldwide.com # Account your authenicating to Exchange with

$access = "SendAs"
$mailbox = Get-EXOMailbox -Identity dev@piscesworldwide.com # Targeted mailbox in which your assigning permissions
$identity = $mailbox.UserPrincipalName
$permissions = Get-EXOMailboxPermission -identity $identity

$users = Get-Content "C:\Users\TerrellBryant\Downloads\Engineering - Software_2023-5-22.csv"   # Filepath for CSV of usernames, easily downloadable from Azure AD group your targeting
foreach($user in $users){
    try{
        $setPermissions = Add-RecipientPermission -Identity $identity -Trustee $user -AccessRights $access
        Write-Host "Successfully added permissions for $user" -ForegroundColor Green
    }catch{
        Write-Host "Failed to add permissions for $user" -ForegroundColor Red
    }
}



Get-PSSession | Remove-PSSession