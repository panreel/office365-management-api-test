# office365-management-api-test
A toolset to test Office 365 Management API

## Setting up the environment

### 1. Application Registration in Azure AD

Following the [Getting Started Guide](https://msdn.microsoft.com/en-us/library/office/dn707383.aspx#sectionSection1 "Getting Started Guide"). In order to test Service-to-Service (S2S) mode please be sure to go through the __Configure an X.509 certificate to enable service-to-service calls__ part of the guide.

### 2. Setup the toolset params in configuration file

Setup the params in `config.ps1` file related to your Azure AD / Office 365 subscription.

#### General Params

2.1 __Tenant ID__  
_Note: You can get your tenant-id without using PS following this [guide](http://merill.net/2015/01/how-to-get-the-azure-ad-tenant-id-without-powershell/ "TenantID Guide")._  
`$tid = "{your-tenant-id}"`  

2.2 __Client ID__  
_Find it in your configuration pane for you Azure AD app_  
`$clientID = "{your-app-client-id}"`  

2.3 __Client Secret__  
_Find it in your configuration pane for you Azure AD app under the Keys entry_  
_If no keys are present generate one and paste the value here_  
`$clientSecret = "{your-app-client-secret}"`  

2.4 __Redirect URL__  
_Find it in your configuration pane for you Azure AD app_  
`$redirectURI = "{your-redirect-URL-for-oauth2-web-based-authentication}"`  

2.5 __Authorize Code__  
_Get it by calling `https://login.microsoftonline.com/common/oauth2/authorize?` endpoint._  
_More info for getting it in the next section_    
`$authCode = "{your-authorization-code}"`  
  
#### Service to Service (S2S) Mode Params  
  
2.6 __Enable S2S__  
_Choose if enabling S2S_  
`$isS2SEnabled = {$True OR $False}`  

2.7 __Certificate Path (PFX)__  
_If S2S is enabled, a pfx cert is required to generate a valid JWT token._  
__Cert should be placed in the `jwt-token-creation\certs\` folder__  
`$relativeCertPath = "\jwt-token-creation\certs\{your-pfx-name-used-to-create-jwt-s2s-token}.pfx"`  

2.8 __Certificate Password__  
_If S2S is enabled, the password for the PrK stored in the pfx cert. This is required to generate a valid JWT token._  
`$certPassword = "{your-pfx-private-key-password-used-to-create-jwt-s2s-token}"`  

## 3. Run the test

The scope of the test is to validate if authentication to Azure AD succeeds (in Web-based auth or S2S) and perform a test call to retrieve existing subscriptions.

Note: In order to get some results from the test REST call, you need to activate at least one subscription to some of the monitorable workloads via Management APIs. To activate a subscription, please follow [Available Operations Guide](https://msdn.microsoft.com/EN-US/library/office/mt227394.aspx#sectionSection0 "Available Operations Guide") and start a subscription POSTing to `/subscriptions/start?contentType={ContentType}` endpoint.

### 3.1 Testing Web-based authentication (i.e. `$isS2SEnabled = $False`)

3.1.1 Retrieve an authorization code (do this for every test run - authorization code gets invalidated after an access token is generated). To do this, open your browser to `https://login.microsoftonline.com/common/oauth2/authorize?response_type=code&resource=https://manage.office.com&client_id={your-app-client-id}&redirect_uri={your-redirect-URL-for-oauth2-web-based-authentication}`, replacing {}s with your params. If your tenant admin hasn't granted consent for this app, perform this operation (just for the first time) using an administrator account. After authentication to Azure AD, you will be redirected to `redirect_uri` page, which will have a `?code={CODE-TO-COPY}` in its URL. Copy the code and paste in `config.ps1` file in the root folder.

3.1.2 Run the test by calling from Powershell `.\O365ManagementAPI.ps1`

### 3.2 Testing S2S authentication (i.e. `$isS2SEnabled = $True`)

3.2.1 Make sure you have your certificate placed in `$relativeCertPath = "\jwt-token-creation\certs\{your-pfx-name-used-to-create-jwt-s2s-token}.pfx"`. After that, make sure you have updated your Azure AD App Certificate according to the one you use here. If you didn't do that, follow the [Getting Started Guide](https://msdn.microsoft.com/en-us/library/office/dn707383.aspx#sectionSection1 "Getting Started Guide") and the __Configure an X.509 certificate to enable service-to-service calls__ section.

3.2.2 Run the test by calling from Powershell `.\O365ManagementAPI.ps1`

## Notes

This toolset was written by using `cURL` command to perform REST calls, since the need for developing it rises in a Linux/UNIX context. The porting to Win used for this toolset can be found [here](http://curl.haxx.se/ "cURL Windows"). In Win-based environments the suggestion is to use `Invoke-RestMethod` command (See [here](http://blogs.technet.com/b/heyscriptingguy/archive/2013/10/21/invokerestmethod-for-the-rest-of-us.aspx "Invoke-RestMethod")).
