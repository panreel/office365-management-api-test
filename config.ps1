# -- Tenant & App Params

# Tenant ID
$tid = "788b987f-329f-40a6-ac84-dfbb22668d08"
# Client ID
$clientID = "9c630582-94af-4836-9ff2-429d92a6d141"
# Client Secret
$clientSecret = "/VIYRPoDvqMHkZCj4S0OcHdEoOj6RD/INBSUbksA780="
# Redirect URL
$redirectURI = "http://localhost/redirect"
# Authorize Code -> Get it by calling https://login.microsoftonline.com/common/oauth2/authorize?response_type=code&resource=https://manage.office.com&client_id={YOUR-CLIENT-ID}&redirect_uri={REDIRECT_URI}
$authCode = "AAABAAAAiL9Kn2Z27UubvWFPbm0gLZbrkDIn84qJ_AVl629xlqAOtp6BsaZkdcC3F7SX2Wq2efLXyKu1bs3UKvpBj_HDfBC7wIl7CJsDAhEHhR5GZpYZWLZDZOI15L-RtUSbeAOIEi-eyXPzoBa9-GAWKUjCYxABIq-ZOUS4ac_Fj5Mkh5b7Rt2goFBU8WWIUCEA3z4Z7ivvTqkqTCDb9jnpOgOx2ylTC5LxmrnYEubjKBnNiIBCtNOVyAZ5Azj2wR7fscx1DLQT7wuYnAL6_saWXE8Zro3ut8Dx33m5Q3clKDnzz_YtuG8GI1lj8ixnwBhRAAa4FrwE-BhA3EtszROrR6x8sH6scG-XdL0SM2FtwaCPbcsyQMR98KiqQtAKLhnCnOt3MEyXcB3fVpo2dDAr991yutqISneQejG99Vs-ZRgG4xTNB5aSiM9yCKEZSS0zKpuPXDxKXlHjPm_f025ZC5NqQr53OqTSHCM1Hd89mld9jeZ2XQFaKtJpi5NeEjfJOuW03TkyWfPzFur_Nq1BHUFDxaDyrIuolgGOaXwQDfeRmAZu0G8JkwNsfQWfB2WnwN2SIAA&session_state=7dc4591f-34d1-4fc3-8c14-c6c7549b70b9"

# -- Service to Service (S2S) Mode Params

# Enable STS
$isS2SEnabled = $True
# Certificate Path (PFX) -> Note: Save pfx in \jwt-token-creation\certs
$relativeCertPath = "\jwt-token-creation\certs\apireporting_pk.pfx"
# Certificate Password
$certPassword = "ciaobelli"

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