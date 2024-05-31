@description('The name of the resource group')
param resourceGroupName string = 'staticwebTheo'

@description('The location for the resource group')
param location string = 'westeurope'

@description('The name of the storage account')
param storageAccountName string

@description('The name of the blob container')
param containerName string = 'web'

@description('The path to the local file to upload')
param localFilePath string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' existing = {
  name: resourceGroupName
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storageAccount.name}/default/${containerName}'
  properties: {
    publicAccess: 'Blob'
  }
}

resource blob 'Microsoft.Storage/storageAccounts/blobServices/containers/blobs@2021-04-01' = {
  name: '${storageAccount.name}/default/${containerName}/${localFilePath}'
  dependsOn: [
    blobContainer
  ]
  properties: {
    blobType: 'Block'
  }
  body: loadFileAsBytes(localFilePath)
}

output staticWebsiteUrl string = 'https://${storageAccount.name}.blob.core.windows.net/${containerName}/${localFilePath}'
