#!/bin/bash

# Cambia este nombre si tu servicio se llama diferente
SERVICE_NAME="ms_auth"
PROJECT_NAME="sstonline"
export SERVICE_NAME
export PROJECT_NAME
BASE_DIR=$(pwd)/$SERVICE_NAME
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/build-create.sh"
source "$SCRIPT_DIR/build-programs-default.sh"
source "$SCRIPT_DIR/build-references.sh"
source "$SCRIPT_DIR/build-packages.sh"
source "$SCRIPT_DIR/build-api-helpers.sh"
source "$SCRIPT_DIR/build-default-controllers.sh"
source "$SCRIPT_DIR/build-implementations.sh"
source "$SCRIPT_DIR/build-infrastructure-folders.sh"
source "$SCRIPT_DIR/build-docker-and-pipeline.sh"

create_base_dirs
cd "$BASE_DIR"

create_solution
create_projects
create_program_cs
add_solution_projects
add_project_references
add_test_references
create_api_helpers
create_default_controllers
create_domain_and_service_implementations
create_infrastructure_folders
create_dockerfile_and_pipeline
install_api_packages
install_infrastructure_packages

echo ""
echo "✅ Solución '$SERVICE_NAME' creada exitosamente con arquitectura Clean Architecture + Worker + tests."
 