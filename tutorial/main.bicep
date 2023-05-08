resource storageaccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'theothecoolcryptoguy'
  location: 'westus3'
  sku:{
    name: 'Standard_LRS'
  }
  kind:'StorageV2'
  properties:{
    accessTier:'Hot'
  }
}
resource appServicePlan 'Microsoft.Web/serverFarms@2022-03-01' = {
  name: 'asp-wu3-cim-training-tt'
  location: 'westus3'
  sku: {
    name: 'F1'
  }
}

resource appServiceApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'as-wu3-cim-training-tt'
  location: 'westus3'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
