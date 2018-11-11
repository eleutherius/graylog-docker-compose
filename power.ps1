
$user_name=user3
$group=wifi

$passwd=get-random -count 9 -input (48..57 + 65..90 + 97..122) | % -begin { $pass = $null } -process {$pass += [char]$_} -end {$pass}
$Attributes = @{
   Enabled = $true
   ChangePasswordAtLogon = $true
   UserPrincipalName = "test.guy@pdqlabs.org"
   Name = "Test.Guy"
   GivenName = "Test"
   Surname = "Guy"
   DisplayName = "Test Guy III"
   Description = "This is the account for the third test guy."
   Office = "No office for test guy."
   Company = "PDQ.com"
   Department = "IT"
   Title = "Some guy"
   City = "Salt Lake City"
   State = "Utah"
   AccountPassword = "$passwd" | ConvertTo-SecureString -AsPlainText -Force
}
New-ADUser @Attributes
Add-AdGroupMember -Identity $group -Members $user_name
Get-Service | Format-Table -Property * -AutoSize | Out-File service.txt -Width 1024
Get-Content service.txt | Out-Printer
