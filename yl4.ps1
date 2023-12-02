$eesnimi = Read-Host "Sisesta enda eesnimi"
$perenimi = Read-Host "Sisesta oma perenimi"
$kasutajanimi = "$eesnimi.$perenimi".ToLower()
Write-Host "Kustutatav kasutaja on" $kasutajanimi
Try {
Remove-ADUser -Identity $kasutajanimi -ErrorAction Stop
Remove-Item -Path "C:\Users\$kasutajanimi" -Recurse -Force

Write-Host "Kasutaja kustutamine õnnestus."
}
Catch {
Write-Host "Kasutaja kustutamine ebaõnnestus"
} 