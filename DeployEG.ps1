param (
    [string]$subscriptionId = ""
)

$resourceGroupName = "nw-sec-automate"
$topicName = "evtgr-topic"

az account set --subscription $subscriptionId

az group create -l northeurope -n $resourceGroupName

az eventgrid system-topic create `
        -g $resourceGroupName `
        --name $topicName `
        --location "global" `
        --topic-type "Microsoft.Resources.Subscriptions" `
        --source "/subscriptions/$subscriptionId"
