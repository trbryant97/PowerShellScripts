# Author: Terrell Bryant
# Created 02/23/2022
# Version 1.0
# Purpose: Searches computer for McAfee installation folder and forcefully uninstalls the McAfee Agent. 
# Removes all other software that was installed with the McAfee ePO software.

$MAPATH = 'C:\Program Files\McAfee\Agent\x86'
$FRMPATH = 'C:\Program Files\McAfee\Agent\x86\FrmInst.exe'
$MAAGENT = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "McAfee Agent"}
$ENDPOINTATP = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "McAfee Endpoint Security Threat Protection"}
$ENDPOINTSP = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "McAfee Endpoint Security Platform"}
$ENDPOINTTP = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "McAfee Endpoint Security Threat Prevention"}
$ENDPOINTWC = Get-WmiObject -Class Win32_Product | Where-Object{$_.Name -eq "McAfee Endpoint Security Web Control"}



# Run remove FrmInst.exe /forceuninstall
try
{


if(Test-Path -Path $MAPATH)
{
    Write-Host -f green $MAPATH "exist"
    Write-Host -f green "removing McAfee Agent"
    Start-Process -FilePath $FRMPATH -ArgumentList "/forceuninstall"
    $MAAGENT.Uninstall()
    Write-Host -f green "McAfee Agent has been removed"

# Check for and remove Endpoint Security Adaptive Threat Protection
$ENDPOINTATP.Uninstall()

# Check for and remove Endpoint Security Platform
$ENDPOINTSP.Uninstall()

# Check for and remove Endpoint Security Threat Prevention
$ENDPOINTTP.Uninstall()

# Check for and remove Endpoint Security Web Control
$ENDPOINTWC.Uninstall()
}
else 
{
    Write-Host "McAfee agent is not installed"
}
Write-Host "Script Done"
}
catch
{
    Write-Host "Script Ran Successfully"
}


