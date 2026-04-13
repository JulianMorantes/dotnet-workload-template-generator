#!/bin/bash

create_base_dirs() {
  mkdir -p "$BASE_DIR/src"
  mkdir -p "$BASE_DIR/tests"
}

create_solution() {
  dotnet new sln -n "$SERVICE_NAME"
}

create_projects() {
  dotnet new classlib -n "$SERVICE_NAME.Domain" -o src/"$SERVICE_NAME.Domain"
  dotnet new classlib -n "$SERVICE_NAME.Application" -o src/"$SERVICE_NAME.Application"
  dotnet new classlib -n "$SERVICE_NAME.Infrastructure" -o src/"$SERVICE_NAME.Infrastructure"

  dotnet new webapi -n "$SERVICE_NAME.Api" -o src/"$SERVICE_NAME.Api" --no-https
  dotnet new worker -n "$SERVICE_NAME.Worker" -o src/"$SERVICE_NAME.Worker"

  dotnet new xunit -n "$SERVICE_NAME.UnitTests" -o tests/"$SERVICE_NAME.UnitTests"
  dotnet new xunit -n "$SERVICE_NAME.IntegrationTests" -o tests/"$SERVICE_NAME.IntegrationTests"
}
