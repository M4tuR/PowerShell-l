$eesnimi = Read-Host "Sisesta enda eesnimi"
$perenimi = Read-Host "Sisesta oma perenimi"
$kasutajanimi = "$eesnimi.$perenimi".ToLower()
Write-Host "Kustutatav kasutaja on" $kasutajanimi
Try {
Remove-LocalUser -Name $kasutajanimi -ErrorAction Stop
Write-Host "Kasutaja kustutamine õnnestus."
}
Catch {
Write-Host "Kasutaja kustutamine ebaõnnestus"
}