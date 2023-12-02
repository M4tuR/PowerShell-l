$file = "C:\Users\Administrator\Documents\adkasutajad1.csv"
$users = Import-Csv $file -Encoding Default -Delimiter ";"
$results = @()

foreach ($user in $users){
    $username = $user.FirstName + "." + $user.LastName
    $username = $username.ToLower()
    $username = Translit($username)
    $upname = $username + "@sv-kool.local"
    $displayname = $user.FirstName + " " + $user.LastName
    $existingUser = Get-ADUser -Filter {SamAccountName -eq $username}

    if ($existingUser -eq $null) {
        $newPassword = GenerateStrongPassword 8
        echo "Lisatud uus kasutaja: $displayname"
        
        New-ADUser -Name $username `
                    -DisplayName $displayname `
                    -GivenName $user.FirstName `
                    -Surname $user.LastName `
                    -Department $user.Department `
                    -Title $user.Role `
                    -UserPrincipalName $upname `
                    -AccountPassword (ConvertTo-SecureString $newPassword -AsPlainText -Force) -Enabled $true

       
        $results += [PSCustomObject]@{
            "Username" = $username
            "CreatedPassword" = $newPassword
        }
    } else {
        echo "Kasutaja juba olemas: $displayname"
    }
}

$results | Export-Csv -Path "C:\Users\Administrator\Documents\kasutajanimi.csv" -NoTypeInformation

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

    $outputString = ""
    foreach ($character in $inputString.ToCharArray()){
        if ($Translit[$character] -ne $null) {
            $outputString += $Translit[$character]
        } else {
            $outputString += $character
        }
    }

    Write-Output $outputString
}

Function GenerateStrongPassword {
    param (
        [Parameter(Mandatory=$true)]
        [int]$PasswordLength
    )

    Add-Type -AssemblyName System.Web
    $PassComplexCheck = $false

    do {
        $newPassword = [System.Web.Security.Membership]::GeneratePassword($PasswordLength, 1)

        if ($newPassword -cmatch "[A-Z\p{Lu}\s]" -and
            $newPassword -cmatch "[a-z\p{Ll}\s]" -and
            $newPassword -match "[\d]" -and
            $newPassword -match "[^\w]"
        ) {
            $PassComplexCheck = $True
        }
    } while ($PassComplexCheck -eq $false)

    return $newPassword
}
