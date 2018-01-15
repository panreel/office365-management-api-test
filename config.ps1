# -- Tenant & App Params

# Tenant ID
$tid = ""
# Client ID
$clientID = ""
# Client Secret
$clientSecret = ""
# Redirect URL
$redirectURI = "http://localhost/redirect"
# Authorize Code -> Get it by calling https://login.microsoftonline.com/common/oauth2/authorize?response_type=code&resource=https://manage.office.com&client_id={YOUR-CLIENT-ID}&redirect_uri={REDIRECT_URI}
$authCode = ""

# -- Service to Service (S2S) Mode Params

# Enable STS
$isS2SEnabled = $True
# Certificate Path (PFX) -> Note: Save pfx in \jwt-token-creation\certs
$relativeCertPath = "\jwt-token-creation\certs\apireporting_pk.pfx"
# Certificate Password
$certPassword = ""

# -- Default params -- Note: DON'T EDIT

# Tenant OAUTH2 token endpoint prefix
$tenantTokenRESTEndpointPrefix = "https://login.windows.net/"
# Tenant OAUTH2 token endpoint suffix
$tenantTokenRESTEndpointSuffix = "/oauth2/token"
# Resource Param
$resource = "https://manage.office.com"
# Grant Type - Authorization_Code
$grantTypeAC = "authorization_code"
# Grant Type - Client_Credentials
$grantTypeCC = "client_credentials"
# Client Assertion Type
$clientAssertionType = "urn:ietf:params:oauth:client-assertion-type:jwt-bearer"

# -- Params Initialization -- Note: DON'T EDIT

# Common OAUTH2 token endpoint
$commonTokenRESTEndpoint = $tenantTokenRESTEndpointPrefix + "common" + $tenantTokenRESTEndpointSuffix
# Tenant OAUTH2 token endpoint
$tenantTokenRESTEndpoint = $tenantTokenRESTEndpointPrefix + $tid + $tenantTokenRESTEndpointSuffix
# S2S audience
$audience = $tenantTokenRESTEndpoint
# S2S issuer
$issuer = $clientID
# S2S subject
$subject = $clientID
# S2S JWT ID
$jti = ([guid]::NewGuid()).Guid

# Setup cURL params
$requestPOST = "-X POST"
$authCodeParam = "-d code=" + $authCode
$resourceParam = "-d resource=" + $resource
$clientIDParam = "-d client_id=" + $clientID
$redirectURIParam = "-d redirect_uri=" + $redirectURI
$clientSecretParam = "-d client_secret=" + $clientSecret
$grantTypeACParam = "-d grant_type=" + $grantTypeAC
$grantTypeCCParam = "-d grant_type=" + $grantTypeCC
$clientAssertionTypeParam = "-d client_assertion_type=" + $clientAssertionType
