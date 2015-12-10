# Install JWT Handler - * DO THIS ONLY IF not already installed in \bin > Move created folder in \bin *
# .\bin\nuget.exe Install System.IdentityModel.Tokens.JWT

# Add .NET framework class in current PS session
Add-Type -Path '.\jwt-token-creation\bin\System.IdentityModel.Tokens.Jwt.4.0.2.206221351\lib\net45\System.IdentityModel.Tokens.Jwt.dll'

# Import Jwt-CreateToken function
. '.\jwt-token-creation\utils\Jwt_CreateToken_Definition.ps1'

# Example creating/reading a token  
$absoluteCertPath = (Get-Location).Path + $relativeCertPath
$claims = New-Object System.Collections.Generic.List[System.Security.Claims.Claim]  
# Add subject in JWT
$claims.Add((New-Object System.Security.Claims.Claim("sub", $subject)))  
# Add JWT ID in JWT
$claims.Add((New-Object System.Security.Claims.Claim("jti", $jti)))  
$encToken = Jwt-CreateToken -issuer $issuer -audience $audience -certificate $absoluteCertPath -certificatePassword $certPassword -claims $claims  
Write-Host " -- JWT Token Created`n" -foregroundcolor "Green"
Write-Host "$encToken"
