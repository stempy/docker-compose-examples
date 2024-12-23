---
created: 2024-12-24
createdby: rob@stemp.dev
---

# Azure Service bus Emulator

> IMPORTANT: as of 2024-11-24 the emulator is NOT compatible with the Azure Service Bus Explorer - [Read more](https://github.com/Azure/azure-service-bus-emulator-installer#interact-with-the-emulator)


- https://techcommunity.microsoft.com/blog/messagingonazureblog/introducing-local-emulator-for-azure-service-bus/4304457
- https://github.com/Azure/azure-service-bus-emulator-installer
- https://github.com/Azure/azure-service-bus-emulator-installer/blob/main/ServiceBus-Emulator/Config/Config.json

- [config.json](https://github.com/Azure/azure-service-bus-emulator-installer/blob/main/ServiceBus-Emulator/Config/Config.json)

- https://learn.microsoft.com/en-us/azure/service-bus-messaging/test-locally-with-service-bus-emulator?tabs=docker-linux-container

## Quick Start

```sh
./compose.ps1 azureservicebus
```

- https://learn.microsoft.com/en-us/azure/service-bus-messaging/test-locally-with-service-bus-emulator?tabs=docker-linux-container#interact-with-the-emulator

### Connection Strings

*local machine*
```
"Endpoint=sb://localhost;SharedAccessKeyName=RootManageSharedAccessKey;SharedAccessKey=SAS_KEY_VALUE;UseDevelopmentEmulator=true;"
```

