# PowerShell script to list the DLL files under the system32 folder
$ext = $args[0]

if ($ext)
{
	Write-Host "Looking for files with extension: $ext ..."	
} else
{
	Write-Host "No file extension provided. Exiting."
	exit
}


$Dir = get-childitem C:\Users\922775 -recurse
# $Dir |get-member
$List = $Dir | where {$_.extension -eq ".$ext"}
$List | format-table #name