param location string = 'westeurope'
param name string = 'theostorage008' // must be globally unique

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: name
  location: location
  kind: 'Storage'
  sku: {
      name: 'Standard_LRS'
  }
}