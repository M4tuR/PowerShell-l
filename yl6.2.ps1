$eesnimi = Read-Host "Sisesta enda eesnimi"
$perenimi = Read-Host "Sisesta oma perenimi"
$kasutajanimi = "$eesnimi.$perenimi".ToLower()
Write-Host "Varundatav kasutaja on" $kasutajanimi
$testUser = $kasutajanimi
$testUserBackupFile = "$backupDirectory\$testUser-$(Get-Date -Format 'dd.MM.yyyy').zip"
$juurkataloog = "C:\Users\$testUser"
# Kui varundusfail eksisteerib
if (Test-Path $testUserBackupFile) {
    # Pakib lahti varunduse
    Expand-Archive -Path $testUserBackupFile -DestinationPath "C:\Users" -Force
    Set-ADUser -Identity $testUser -HomeDirectory $juurkataloog -HomeDrive "C:"
    Write-Host "Varunduse lahtipakkimine lõpetatud."
} else {
    Write-Host "Varundust ei leitud kasutajale: $testUser"
}