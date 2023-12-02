$file = "C:\Users\Administrator\Documents\adkasutajad.csv"
$users = Import-Csv $file -Encoding Default -Delimiter ";"
foreach ($user in $users){
$username = $user.FirstName + "." + $user.LastName
$username = $username.ToLower()
$username = Translit($username)
$upname = $username + "@sv-kool.local"
$displayname = $user.FirstName + " " + $user.LastName
$existingUser = Get-ADUser -Filter {SamAccountName -eq $username}

    if ($existingUser -eq $null) {
       
        echo "Lisatud uus kasutaja: $displayname"
New-ADUser -Name $username `
          -DisplayName $displayname `
          -GivenName $user.FirstName `
          -Surname $user.LastName `
          -Department $user.Department `
          -Title $user.Role `
          -UserPrincipalName $upname `
          -AccountPassword (ConvertTo-SecureString $user.Password -AsPlainText -Force) -Enabled $true
} else {
        echo "Kasutaja juba olemas: $displayname"
    }
}
function Translit {
param(
[string] $inputString
)
$Translit = @{
[char]'ä' = "a"
[char]'ö' = "o"
[char]'ü' = "u"
[char]'õ' = "o"
}
$outputString=""
foreach ($character in $inputCharacter = $inputString.ToCharArray())
{
if ($Translit[$character] -cne $Null ){
$outputString += $Translit[$character]
} else {
$outputString += $character
}
}
Write-Output $outputString
}