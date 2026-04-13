#!/bin/bash

create_dockerfile_and_pipeline() {
  # Dockerfile
  cat > Dockerfile <<EOF
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy csproj files and restore dependencies
COPY ["src/$SERVICE_NAME.Api/$SERVICE_NAME.Api.csproj", "src/$SERVICE_NAME.Api/"]
COPY ["src/$SERVICE_NAME.Application/$SERVICE_NAME.Application.csproj", "src/$SERVICE_NAME.Application/"]
COPY ["src/$SERVICE_NAME.Domain/$SERVICE_NAME.Domain.csproj", "src/$SERVICE_NAME.Domain/"]
COPY ["src/$SERVICE_NAME.Infrastructure/$SERVICE_NAME.Infrastructure.csproj", "src/$SERVICE_NAME.Infrastructure/"]
COPY ["src/$SERVICE_NAME.Worker/$SERVICE_NAME.Worker.csproj", "src/$SERVICE_NAME.Worker/"]

RUN dotnet restore "src/$SERVICE_NAME.Api/$SERVICE_NAME.Api.csproj"

# Copy everything else and build
COPY . .
WORKDIR "/src/src/$SERVICE_NAME.Api"
RUN dotnet build "$SERVICE_NAME.Api.csproj" -c Release -o /app/build

# Publish stage
FROM build AS publish
RUN dotnet publish "$SERVICE_NAME.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "$SERVICE_NAME.Api.dll"]
EOF


# Azure Pipelines
  cat > azure-pipelines.yml <<EOF
trigger:
  branches:
    include:
      - master
      - develop
      - release/*

pool:
  vmImage: 'ubuntu-latest'

variables:
  - group: ${PROJECT_NAME}-${SERVICE_NAME}

resources:
  repositories:
    - repository: templatesRepo
      type: git
      name: UiCode/UiCode-GitOps
      ref: refs/heads/master
      persistCredentials: false

stages: 
  - template: pipelines/templates/stages/build.microservices.yaml@templatesRepo
    parameters: 
      projectName: '${SERVICE_NAME}_api'
      pathToGitOps : 'applications/${PROJECT_NAME}/microservices/${SERVICE_NAME}'
      solutionName : '${SERVICE_NAME}'
EOF
}