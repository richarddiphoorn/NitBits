<#
        .Synopsis
        Get the properties for a DSC resource.
        .DESCRIPTION
        Every PowerShell DSC Resource has specific values to be configured.
        Instead of trying to figure out which values you can use, this command outputs the values of a DSC Resource.
        Also you can copy the output to the clipboard, to paste it in your editor.
        Inspiration for this function is provided by Stephen Owen (http://www.foxdeploy.com)
        .EXAMPLE
        This example gets the properties of the DSC Resource 'User', and copies it to the clipboard.
        Get-DscResourceProperties -Name User -CopyToClipboard
        .NOTES
        Version: 1.0
        Author: Richard Diphoorn
        Creation Date: 2015-12-05
        Purpose/Change: Initial Release
#>
function Get-DscResourceProperties
{
    [CmdletBinding()]

    Param
    (
        [Parameter(Mandatory = $true,ValueFromPipeline = $true,Position = 0)]$Name,
        
        [Parameter()][Switch]$CopyToClipboard
    )

    $dscProperties = Get-DscResource -Name $Name |
    Select-Object -ExpandProperty Properties |
    Select-Object -ExpandProperty Name |
    ForEach-Object -Process {
        "$_=`'`'"
    } 
    
            
    if ($CopyToClipboard)
    {
        $dscProperties |
        clip.exe
    }
    else 
    {
        Write-Output -InputObject $dscProperties
    }
}
