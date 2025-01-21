# Living off the Land Discovery Tactic Simulation

# Set output file path
$outputFile = "DiscoveryOutput.txt"

# Function to write output to file
function Write-OutputToFile {
    param(
        [string]$content
    )
    $content | Out-File -Append -FilePath $outputFile
}

# Get system information (Host name, OS, architecture)
$sysInfo = Get-WmiObject Win32_OperatingSystem
Write-OutputToFile "System Information:"
Write-OutputToFile "Host Name: $($sysInfo.CSName)"
Write-OutputToFile "OS: $($sysInfo.Caption)"
Write-OutputToFile "Architecture: $($sysInfo.OSArchitecture)"
Write-OutputToFile "Version: $($sysInfo.Version)"
Write-OutputToFile "Build Number: $($sysInfo.BuildNumber)"
Write-OutputToFile ""

# Get network configuration (IP address, subnet, gateway)
$networkConfig = Get-NetIPAddress | Where-Object {$_.IPAddress -ne '127.0.0.1' -and $_.PrefixLength -ne 32}
Write-OutputToFile "Network Configuration:"
$networkConfig | ForEach-Object {
    Write-OutputToFile "IP Address: $($_.IPAddress)"
    Write-OutputToFile "Subnet Mask: $($_.PrefixLength)"
    Write-OutputToFile "Default Gateway: $($_.DefaultGateway)"
    Write-OutputToFile ""
}

# List active users on the system
$activeUsers = Get-WmiObject -Class Win32_ComputerSystem
Write-OutputToFile "Active User(s):"
Write-OutputToFile "Logged on User: $($activeUsers.UserName)"
Write-OutputToFile ""

# Get list of running processes (can be used to find running apps or scripts)
$runningProcesses = Get-Process
Write-OutputToFile "Running Processes:"
$runningProcesses | Select-Object Name, Id, CPU | Format-Table -AutoSize | Out-File -Append -FilePath $outputFile
Write-OutputToFile ""

# Get list of all local users
# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory
# Get list of all AD users
$adUsers = Get-ADUser -Filter * -Properties Enabled
Write-OutputToFile "Active Directory Users:"
$adUsers | Select-Object SamAccountName, Enabled | Format-Table -AutoSize | Out-File -Append -FilePath $outputFile
Write-OutputToFile ""

# Get shares on the system (potential for accessing files)
$shares = Get-WmiObject -Class Win32_Share
Write-OutputToFile "Shared Folders:"
$shares | Select-Object Name, Path | Format-Table -AutoSize | Out-File -Append -FilePath $outputFile
Write-OutputToFile ""

# Discover domain information (if applicable)
$domainInfo = Get-WmiObject Win32_ComputerSystem
Write-OutputToFile "Domain Information:"
Write-OutputToFile "Domain: $($domainInfo.Domain)"
Write-OutputToFile "Workgroup: $($domainInfo.Workgroup)"
Write-OutputToFile ""

# End of Discovery Simulation
Write-OutputToFile "Discovery tactics completed."