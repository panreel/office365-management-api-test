# Setup a bunch of calls to test O365 Management API

# Import ENV vars
. '.\config.ps1'

If(-Not $isS2SEnabled) {

	Write-Host "`n -- NO S2S Enabled -> Human Simulation (check you have the correct authCode in config.ps1)`n"

	Write-Host "`n -- Retrieving AccessToken from Azure...`n"
	# Perform /token request towards common endpoint
	$jsonToken = & '.\bin\curl.exe' $requestPOST $commonTokenRESTEndpoint $resourceParam $clientIDParam $redirectURIParam $clientSecretParam $grantTypeACParam $authCodeParam

	# parse JSON
	$parsedJson = $jsonToken | ConvertFrom-Json

	If($parsedJson.error) {
		Write-Host "`n`nError" -foregroundcolor "red"
		Write-Host "--------`n$jsonToken`n"
	} Else {
		Write-Host "`n`Access Token OK" -foregroundcolor "green"
		Write-Host "--------`n$jsonToken`n"
	}

} Else {

	Write-Host "`n -- S2S Enabled -> Daemon Simulation (Client Certificate Mode seems enabled)`n"

	. '.\jwt-token-creation\O365ManagementAPI_getPK.ps1'

	$clientAssertion = "-d client_assertion=" + $encToken

	Write-Host "`n -- Retrieving AccessToken from Azure...`n"
	# Perform /token request towards common endpoint
	$jsonToken = & '.\bin\curl.exe' $requestPOST $tenantTokenRESTEndpoint $resourceParam $clientIDParam $grantTypeCCParam $clientAssertionTypeParam $clientAssertion

	# parse JSON
	$parsedJson = $jsonToken | ConvertFrom-Json

	If($parsedJson.error) {
		Write-Host "`n`nError" -foregroundcolor "red"
		Write-Host "--------`n$jsonToken`n"
	} Else {
		Write-Host "`n`Access Token OK" -foregroundcolor "green"
		Write-Host "--------`n$jsonToken`n"
	}

}

# extract Access Token
$access_token = $parsedJson.access_token

# setup Header
$header = "Authorization: Bearer " + $access_token 
# setup test URL
$url = "https://manage.office.com/api/v1.0/" + $tid + "/activity/feed/subscriptions/list"

Write-Host " -- Doing a test REST call...`n`n"

$curl = '.\bin\curl.exe'
$testToken = & $curl -H $header $url
$parsedTestToken = ConvertFrom-Json $testToken 

Write-Host "`n`Output" -foregroundcolor "Yellow"
Write-Host "--------`n"

($parsedTestToken | Format-List | Out-String).Trim()

Write-Host "`n"