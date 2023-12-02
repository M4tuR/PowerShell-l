$backupDirectory = "C:\Backup"

# Loob varunduste jaoks kataloogi, kui see ei eksisteeri
if (-not (Test-Path $backupDirectory)) {
    New-Item -ItemType Directory -Path $backupDirectory | Out-Null
}

# Varunda kõikide kasutajate kodukaustad
Get-ChildItem -Path C:\Users -Directory | ForEach-Object {
    $username = $_.Name
    $backupFileName = "$backupDirectory\$username-$(Get-Date -Format 'dd.MM.yyyy').zip"
    
    # Varunda kodukaust zip-failiks
    Compress-Archive -Path $_.FullName -DestinationPath $backupFileName
    Write-Host "Varundatud kasutaja: $username"
}