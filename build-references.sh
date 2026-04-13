#!/bin/bash

add_solution_projects() {
  dotnet sln add src/"$SERVICE_NAME.Domain"/"$SERVICE_NAME.Domain".csproj
  dotnet sln add src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj
  dotnet sln add src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj
  dotnet sln add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj
  dotnet sln add src/"$SERVICE_NAME.Worker"/"$SERVICE_NAME.Worker".csproj
  dotnet sln add tests/"$SERVICE_NAME.UnitTests"/"$SERVICE_NAME.UnitTests".csproj
  dotnet sln add tests/"$SERVICE_NAME.IntegrationTests"/"$SERVICE_NAME.IntegrationTests".csproj
}

add_project_references() {
  dotnet add src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj reference src/"$SERVICE_NAME.Domain"/"$SERVICE_NAME.Domain".csproj
  dotnet add src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj reference src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj
  dotnet add src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj reference src/"$SERVICE_NAME.Domain"/"$SERVICE_NAME.Domain".csproj

  dotnet add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj reference src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj
  dotnet add src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj reference src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj

  dotnet add src/"$SERVICE_NAME.Worker"/"$SERVICE_NAME.Worker".csproj reference src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj
  dotnet add src/"$SERVICE_NAME.Worker"/"$SERVICE_NAME.Worker".csproj reference src/"$SERVICE_NAME.Infrastructure"/"$SERVICE_NAME.Infrastructure".csproj
  dotnet add src/"$SERVICE_NAME.Worker"/"$SERVICE_NAME.Worker".csproj reference src/"$SERVICE_NAME.Domain"/"$SERVICE_NAME.Domain".csproj
}

add_test_references() {
  dotnet add tests/"$SERVICE_NAME.UnitTests"/"$SERVICE_NAME.UnitTests".csproj reference src/"$SERVICE_NAME.Application"/"$SERVICE_NAME.Application".csproj
  dotnet add tests/"$SERVICE_NAME.UnitTests"/"$SERVICE_NAME.UnitTests".csproj reference src/"$SERVICE_NAME.Domain"/"$SERVICE_NAME.Domain".csproj
  dotnet add tests/"$SERVICE_NAME.IntegrationTests"/"$SERVICE_NAME.IntegrationTests".csproj reference src/"$SERVICE_NAME.Api"/"$SERVICE_NAME.Api".csproj
}
