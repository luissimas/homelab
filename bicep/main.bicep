@description('The location in which to deploy the resources.')
param location string = resourceGroup().location

@description('The name of the storage container.')
param storageContainerName string = 'velero'

@description('The name of the storage account.')
param storageAccountName string = 'homelab${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}

resource blobServices 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  name: storageContainerName
  parent: blobServices
  properties: {
    publicAccess: 'None'
  }
}

output storageAccountName string = storageAccount.name
