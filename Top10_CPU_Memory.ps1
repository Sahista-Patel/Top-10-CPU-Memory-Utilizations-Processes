<#
.SYNOPSIS
    This script will display lists of top processes which consumes higher Memory and CPU Utilisation.
.DESCRIPTION
    Two lists with Process Name and its respective CPU and Memory Utilizations.
.INPUTS
    None.
.EXAMPLE
    .\Top10_CPU_Memory.ps1
    This will execute the script and gives two tables as an output.
.NOTES
    PUBLIC
.AUTHOR
    Sahista Patel
    Harsh Paecha
#>



#Object For CPU
$properties=@(
    @{Name="Process Name"; Expression = {$_.name}},
    @{Name="CPU"; Expression = {$_.PercentProcessorTime}}   
)
Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | Sort-Object -Property PercentProcessorTime -Descending |
    Select-Object $properties -First 10 | 
    Format-Table -AutoSize
#Object For Memory
$properties=@(
    @{Name="Process Name"; Expression = {$_.name}},
    @{Name="Memory (MB)"; Expression = {[Math]::Round(($_.workingSetPrivate / 1mb),2)}}
)

Get-WmiObject -class Win32_PerfFormattedData_PerfProc_Process | Sort-Object -Property workingSetPrivate -Descending |
    Select-Object $properties -First 10 | 
    Format-Table -AutoSize 