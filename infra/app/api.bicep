param name string
param location string = resourceGroup().location
param tags object = {}

param allowedOrigins array = []
param appCommandLine string = ''
param applicationInsightsName string = ''
param appServicePlanId string
@secure()
param appSettings object = {}
param keyVaultName string
param serviceName string = 'api'

module api '../core/host/appservice.bicep' = {
  name: '${name}-app-module'
  params: {
    name: name
    location: location
    tags: union(tags, { 'azd-service-name': serviceName })
    allowedOrigins: allowedOrigins
    appCommandLine: appCommandLine
    applicationInsightsName: applicationInsightsName
    appServicePlanId: appServicePlanId
    appSettings: appSettings
    keyVaultName: keyVaultName
    runtimeName: 'node'
    runtimeVersion: '20-lts'
    kind:'windows'
    linuxFxVersion:''
    // https://learn.microsoft.com/en-us/azure/app-service/deploy-zip?tabs=cli#enable-build-automation-for-zip-deploy
    // Node.js apps must be deployed with all the required npm dependencies. 
    // The App Service deployment engine automatically runs npm install --production for you when you deploy a Git repository, 
    // or when you deploy a Zip package with build automation enabled. 
    scmDoBuildDuringDeployment: true
  }
}

output SERVICE_API_IDENTITY_PRINCIPAL_ID string = api.outputs.identityPrincipalId
output SERVICE_API_NAME string = api.outputs.name
output SERVICE_API_URI string = api.outputs.uri
