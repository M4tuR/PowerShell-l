$eesnimi = Read-Host "Sisesta enda eesnimi"
$perenimi = Read-Host "Sisesta oma perenimi"
$kasutajanimi = "$eesnimi.$perenimi".ToLower()
Write-Host "Loodav kasutaja on" $kasutajanimi
$parool = "Parool1!"
$secureString = ConvertTo-SecureString $parool -AsPlainText -Force
$params =@{
Name = $kasutajanimi
Password = $secureString
FullName = "$eesnimi $perenimi"
Description = "Local Acount - $kasutajanimi"
}
New-LocalUser @params