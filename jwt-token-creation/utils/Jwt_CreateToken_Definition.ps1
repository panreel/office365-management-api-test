# Define JWT creation function - source: http://blog.d-apps.com/2013/08/powershell-and-json-web-token-handler.html
function Jwt-CreateToken {  

	Param(  
	[string] $issuer,  
	[string] $audience,  
	[string] $certificate,  
	[string] $certificatePassword,  
	[System.Collections.Generic.List[System.Security.Claims.Claim]] $claims = $null  
	)

	# Make our token valid from now to the next year.  
	$createDate = Get-Date  
	$lifetime = New-Object System.IdentityModel.Protocols.WSTrust.Lifetime($createDate, $createDate.AddYears(1))  

	# Load our certificate.  
	$signingCertificate = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($certificate, $certificatePassword, "Export")  
	# get PrK.
	$signingCredentials = New-Object System.IdentityModel.Tokens.X509SigningCredentials($signingCertificate)  

	# Create our JSON web token.  
	$token = New-Object System.IdentityModel.Tokens.JwtSecurityToken($issuer, $audience, $claims, $lifetime.Created, $lifetime.Expires, $signingCredentials)  
	return (New-Object System.IdentityModel.Tokens.JwtSecurityTokenHandler).WriteToken($token)  

	}