param (
    [int]$FunctionCount = 1,
    [string]$subscriptionId = ""
)

$resourceGroupName = "nw-sec-automate"

az account set --subscription $subscriptionId

az group create -l northeurope -n $resourceGroupName

for ($i = 0; $i -lt $FunctionCount; $i++) {
        $uniqueName = "resourceid" + (Get-Random -Maximum 100) + "$i"
        Write-Host "Deploying $uniqueName."
        az appservice plan create -g $resourceGroupName -n $uniqueName
        az storage account create -n $uniqueName -g $resourceGroupName -l northeurope --sku Standard_LRS
        az functionapp create -g $resourceGroupName  -p $uniqueName -n $uniqueName -s $uniqueName --functions-version 3
}