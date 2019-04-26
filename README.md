# ServerlessWorkshop

# 1. Setup/Preparation
## 1. VMs
![GitHub Logo](/images/logo.png)
## 2. Azure Function
![GitHub Logo](/images/logo.png)
## 3. Eventgrid
![GitHub Logo](/images/ServerlessWorkshop-0001.jpg)
## 4. Logic App
![Log Analytics parameters](/images/ServerlessWorkshop-0000.jpg)
# 2. Network Watcher configuration

To configure Azure Network Watcher, you need to enable Network Watcher on your subscription for the designated region first.
To activate Network Watcher
1. Search for Network Watcher in the Azure Portal
2. Select and expand the region you want to activate
3. Click on the three dots to the right and select "Enable network watcher"

![Network Watcher](/images/ServerlessWorkshop-0002.jpg) 

# 3. Azure Functions configuration
## 1. Configure MSI
## 2. Write Azure Functions Code

To run and debug Azure functions locally with Visual Studio Code, you need the following requirements:
- Install PowerShell Core (https://github.com/PowerShell/PowerShell/releases)[https://github.com/PowerShell/PowerShell/releases]
- Install the .NET Core SDK 2.1+ (https://dotnet.microsoft.com/download)[https://dotnet.microsoft.com/download]
- Install Azure Functions Core Tools version 2.4.299 or later `npm i -g azure-functions-core-tools@2`
- Install Azure Functions extension in Visual Studio Code (https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)[https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions]

# 6. Eventgrid configuration
# 7. Logic App configuration
# 8. Simulate VM traffic
1. Clone this repo: https://github.com/ubeeri/Invoke-UserSimulator
2. Import the script modules:
`PS>Import-Module .\Invoke-UserSimulator.ps1`
3. Run only the Internet Explorer function on the local host:
`PS>Invoke-UserSimulator -StandAlone -IE`
# 9. Bring everything together
