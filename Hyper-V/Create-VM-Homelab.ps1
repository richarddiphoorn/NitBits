$vmName = 'RIKER'
$vmSwitch = 'Corpnet'
$vmPath = 'C:\VMs'
$vmParentPath = 'C:\VMs\W2012R2-Base\Virtual Hard Disks\W2012R2-Base.vhdx'
New-VM -Name $vmName -MemoryStartupBytes 1024MB -NoVHD -SwitchName $vmSwitch -Generation 2 -Path $vmPath
New-VHD -Path "$vmPath\$vmName\Virtual Hard Disks\$vmName.vhdx" -Differencing -ParentPath $vmParentPath -SizeBytes 50GB
Add-VMHardDiskDrive -VMName $vmName -Path "$vmPath\$vmName\Virtual Hard Disks\$vmName.vhdx"
Set-VM $vmName -ProcessorCount 2 -DynamicMemory -MemoryMinimumBytes 1024MB -MemoryMaximumBytes 1GB -AutomaticStartAction Nothing
Enable-VMIntegrationService -Name * -VMName $vmName


New-NetIPAddress -InterfaceAlias Ethernet -IPAddress '10.0.0.51' -AddressFamily IPv4 -PrefixLength 8 -DefaultGateway '10.0.0.1'
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses '10.0.0.51'
New-NetFirewallRule –DisplayName 'Allow ICMPv4-In' –Protocol ICMPv4
New-NetFirewallRule –DisplayName 'Allow ICMPv4-Out' –Protocol ICMPv4 –Direction Outbound
Add-Computer -DomainName 'corp.quantica.nl' -Credential (Get-Credential -UserName 'corp\administrator') -NewName 'TL03-DSCT01' -Restart
