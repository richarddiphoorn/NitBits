# Add the new path to the $p variable. Begin with a semi-colon separator.
$p = 'C:\Users\RichardDiphoorn\Documents\WindowsPowerShell\Modules'
$p += ';C:\Program Files\WindowsPowerShell\Modules'
$p += ';C:\Program Files\system32\WindowsPowerShell\v1.0\Modules'
$p += ';C:\Program Files\SharePoint Online Management Shell'
$p += ';C:\Program Files\Common Files\Skype for Business Online\Modules'

# Add the paths in $p to the PSModulePath value.
[Environment]::SetEnvironmentVariable('PSModulePath',$p)
