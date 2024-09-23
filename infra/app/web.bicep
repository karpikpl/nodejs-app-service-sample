param name string
param location string = resourceGroup().location
param tags object = {}
param serviceName string = 'web'
param appCommandLine string = ''
param applicationInsightsName string = ''
param appServicePlanId string
@secure()
param appSettings object = {}
param keyVaultName string

module web '../core/host/appservice.bicep' = {
  name: '${name}-deployment'
  params: {
    name: name
    location: location
    appCommandLine: appCommandLine
    applicationInsightsName: applicationInsightsName
    appServicePlanId: appServicePlanId
    appSettings: appSettings
    keyVaultName: keyVaultName
    runtimeName: 'node'
    runtimeVersion: '20-lts'
    kind:'windows'
    linuxFxVersion:''
    tags: union(tags, { 'azd-service-name': serviceName })
    // https://learn.microsoft.com/en-us/azure/app-service/deploy-zip?tabs=cli#enable-build-automation-for-zip-deploy
    // Node.js apps must be deployed with all the required npm dependencies. 
    // The App Service deployment engine automatically runs npm install --production for you when you deploy a Git repository, 
    // or when you deploy a Zip package with build automation enabled. 
    scmDoBuildDuringDeployment: true
  }
}

output SERVICE_WEB_IDENTITY_PRINCIPAL_ID string = web.outputs.identityPrincipalId
output SERVICE_WEB_NAME string = web.outputs.name
output SERVICE_WEB_URI string = web.outputs.uri
