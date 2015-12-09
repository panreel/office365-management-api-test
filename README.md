# office365-management-api-test
A toolset to test Office 365 Management API

## Setting up the environment

### 1. Application Registration in Azure AD

Following the ![alt text](https://msdn.microsoft.com/en-us/library/office/dn707383.aspx#sectionSection1 "Getting Started Guide"). In order to test Service-to-Service (S2S) mode please be sure to go through the __Configure an X.509 certificate to enable service-to-service calls__ part of the guide.

### 2. Setup the toolset params in configuration file

Setup the params in `config.ps1` file related to your Azure AD / Office 365 subscription.

#### General Params

2.1 Tenant ID
_Note: You can get your tenant-id without using PS following this guide: http://merill.net/2015/01/how-to-get-the-azure-ad-tenant-id-without-powershell/_
`$tid = "{your-tenant-id}"`

2.2 Client ID
_Find it in your configuration pane for you Azure AD app_
`$clientID = "{your-app-client-id}"`

2.3 Client Secret
_Find it in your configuration pane for you Azure AD app under the Keys entry - if no keys are present generate one and paste here the value_
`$clientSecret = "{your-app-client-secret}"`

2.4 Redirect URL
_Find it in your configuration pane for you Azure AD app_
`$redirectURI = "{your-redirect-URL-for-oauth2-web-based-authentication}"`

2.5 Authorize Code
_Get it by calling `https://login.microsoftonline.com/common/oauth2/authorize?response_type=code&resource=https://manage.office.com&client_id={your-app-client-id}&redirect_uri={your-redirect-URL-for-oauth2-web-based-authentication}`_
`$authCode = "{your-authorization-code}"`

#### Service to Service (S2S) Mode Params

2.6 Enable STS
_Choose if enabling S2S_
`$isS2SEnabled = {$True OR $False}`

2.7 Certificate Path (PFX) -> Note: Save pfx in \jwt-token-creation\certs
_If S2S is enabled, a pfx cert is required to generate a valid JWT token. Cert should be placed in the `jwt-token-creation\certs\` folder_
`$relativeCertPath = "\jwt-token-creation\certs\{your-pfx-name-used-to-create-jwt-s2s-token}.pfx"`

2.8 Certificate Password
_If S2S is enabled, the password for the PrK stored in the pfx cert. This is required to generate a valid JWT token._
`$certPassword = "{your-pfx-private-key-password-used-to-create-jwt-s2s-token}"`

## 3. Run the test

The scope of the test is to validate if authentication to Azure AD succeeds (in Web-based auth or S2S) and perform a test call to retrieve existing subscriptions.

Note: In order to get some results from the test REST call, you need to activate at least one subscription to some of the monitorable workload via Management APIs. To activate a subscription, please follow ![alt text](https://msdn.microsoft.com/EN-US/library/office/mt227394.aspx#sectionSection0 "Available Operations Guide") and start a subscription POSTing to `/subscriptions/start?contentType={ContentType}` endpoint.

### 3.1 Testing Web-based authentication



### 3.2 Testing S2S authentication



## Notes



