#Step 1
Rename-Computer -NewName DC02
Restart-Computer -Force 

#Step 2
New-NetIPAddress –InterfaceIndex 12 –IPAddress 192.168.2.3 -PrefixLength 24
Set-DNSClientServerAddress –InterfaceIndex 12 -ServerAddresses 192.168.2.2

#Step 3
Add-Computer -DomainName ViaMonstra -Credential (Get-Credential)
Restart-Computer -Force

#Step 4
Install-WindowsFeature -Name AD-Domain-Services

#Step 5
$Password = ConvertTo-SecureString -AsPlainText -String !1Qwertyuiopüõ -Force
Install-ADDSDomainController -DomainName Corp.ViaMonstra.com -DatabasePath '%SYSTEMROOT%\NTDS' -LogPath '%SYSTEMROOT%\NTDS' -SysvolPath '%SYSTEMROOT%\SYSVOL' -InstallDns -ReplicationSourceDC DC01.corp.viamonstra.com -SafeModeAdministratorPassword $Password -NoRebootOnCompletion

#Step 6
Restart-Computer -Force

#Get all the Domain Controllers
Get-ADGroupMember 'Domain Controllers'