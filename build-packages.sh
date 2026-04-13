#!/bin/bash

install_api_packages() {
  dotnet add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj package Swashbuckle.AspNetCore
  dotnet add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj package AutoMapper
  dotnet add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj package Microsoft.AspNetCore.Authentication.JwtBearer 
}

install_infrastructure_packages() {
  dotnet add src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj package MongoDB.Driver
}
