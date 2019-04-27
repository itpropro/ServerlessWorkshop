using namespace System.Net

# Input bindings are passed in via param block.
param($req,$TriggerMetadata)

# Acquire API token
$apiVersion = "2017-09-01"
$resourceURI = "https://management.azure.com/"
$tokenAuthURI = $env:MSI_ENDPOINT + "?resource=$resourceURI&api-version=$apiVersion"
$tokenResponse = Invoke-RestMethod -Method Get -Headers @{"Secret"="$env:MSI_SECRET"} -Uri $tokenAuthURI
$accessToken = $tokenResponse.access_token

Write-Host $accessToken

$subId = "82cc142a-2850-45ec-8f60-64240c0b804e"
$vmRg = "serverless_workshop_gab2019"

# Interact with query parameters or the body of the request.
# $name = $Request.Query.Name

$vmName = $req.Body.vmName
$duration = $req.body.duration
$capName = "$([Datetime]::utcnow.tostring('MM-dd-hh-mm-ss')).cap"

if ($vmName) {
    $status = [HttpStatusCode]::OK
}
else {
    $status = [HttpStatusCode]::BadRequest
    $body = "Please pass a name on the query string or in the request body."
}

# Create packet capture

$body = @"
{
  "properties": {
    "target": "/subscriptions/$subId/resourceGroups/$vmRg/providers/Microsoft.Compute/virtualMachines/$vmName",
    "bytesToCapturePerPacket": 100000,
    "totalBytesPerSession": 100000,
    "timeLimitInSeconds": $duration,
    "storageLocation": {
      "storageId": "/subscriptions/82cc142a-2850-45ec-8f60-64240c0b804e/resourceGroups/serverless_workshop_gab2019/providers/Microsoft.Storage/storageAccounts/gab2019captures",
      "storagePath": "https://gab2019captures.blob.core.windows.net/captures/$capName"
    }
  }
}
"@

$requestArguments = @{ 
    Uri = "https://management.azure.com/subscriptions/82cc142a-2850-45ec-8f60-64240c0b804e/resourceGroups/NetworkWatcherRG/providers/Microsoft.Network/networkWatchers/NetworkWatcher_westeurope/packetCaptures/$($capName)?api-version=2018-11-01"
    Method = 'PUT'
    Headers = @{Authorization="Bearer $accessToken"}
    contentType = 'application/json'
    Body = $body
}

$response = Invoke-WebRequest @requestArguments
$parsed = $response | convertfrom-json

# Associate values to output bindings by calling 'Push-OutputBinding'.
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
    StatusCode = $status
    Body = $parsed.properties.storageLocation.storagePath
})
