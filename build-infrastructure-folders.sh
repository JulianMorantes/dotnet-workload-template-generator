#!/bin/bash

create_infrastructure_folders() {
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Persistence
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Persistence/Migrations
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Persistence/Repositories
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Persistence/Contexts
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Messaging
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Messaging/RabbitMQ
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/Integrations
  mkdir -p src/"$SERVICE_NAME.Infrastructure"/DependencyInjection
}