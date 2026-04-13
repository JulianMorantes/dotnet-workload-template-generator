# DotNet Workload Template Generator

This project is a template generator for creating .NET microservices following Clean Architecture. It automates the creation of a full solution with separated projects, helpers, default controllers, domain and service implementations, and Docker and Azure DevOps pipeline configuration.

## Arquitectura Generada

El generador crea una solución .NET con la siguiente arquitectura **Clean Architecture**:

- **Domain**: Contiene las entidades, interfaces de repositorios y lógica de negocio pura.
- **Application**: Contiene los servicios de aplicación, DTOs y lógica de casos de uso.
- **Infrastructure**: Contiene implementaciones concretas (repositorios, servicios externos, configuración de base de datos).
- **Api**: Proyecto WebAPI con controladores, configuración de Swagger, CORS y Program.cs personalizado.
- **Worker**: Servicio de fondo (background service) para tareas asíncronas.
- **UnitTests**: Pruebas unitarias para la lógica de negocio.
- **IntegrationTests**: Pruebas de integración para endpoints y servicios.

### Estructura de Carpetas Generada

```
ms_auth/
├── src/
│   ├── ms_auth.Domain/
│   ├── ms_auth.Application/
│   ├── ms_auth.Infrastructure/
│   ├── ms_auth.Api/
│   │   ├── Controllers/
│   │   ├── Helpers/
│   │   │   ├── CorsConfig.cs
│   │   │   └── SwaggerConfig.cs
│   │   ├── Program.cs
│   │   └── appsettings.json
│   └── ms_auth.Worker/
├── tests/
│   ├── ms_auth.UnitTests/
│   └── ms_auth.IntegrationTests/
├── Dockerfile
├── azure-pipelines.yml
└── ms_auth.sln
```

## Cómo Usar

### Prerrequisitos

- **.NET 6+** instalado (dotnet CLI).
- **Git** para clonar el repositorio.
- Permisos de ejecución en los scripts bash (ejecuta `chmod +x *.sh` si es necesario).

### Pasos para Generar un Microservicio

1. **Clona o copia el repositorio**:
   ```
   git clone <url-del-repo>
   cd tpl-ms-generator
   ```

2. **Configura el nombre del servicio**:
   Edita `ms-build-generator.sh` y cambia `SERVICE_NAME` (por defecto "ms_auth").

3. **Ejecuta el generador**:
   ```
   ./ms-build-generator.sh
   ```
   Esto creará una carpeta con el nombre del servicio (ej. `ms_auth/`) en el directorio actual.

4. **Navega al proyecto generado**:
   ```
   cd ms_auth
   ```

5. **Restaura paquetes y construye**:
   ```
   dotnet restore
   dotnet build
   ```

6. **Ejecuta la API**:
   ```
   cd src/ms_auth.Api
   dotnet run
   ```
   Accede a Swagger en `https://localhost:5000/swagger`.

7. **Ejecuta pruebas**:
   ```
   dotnet test
   ```

## GitHub Actions

Este repositorio incluye un workflow de GitHub Actions en `.github/workflows/build-and-zip.yml`.

El workflow se ejecuta manualmente con `workflow_dispatch` y recibe dos parámetros de entrada:

- `service_name`: nombre del servicio a generar.
- `project_name`: nombre del proyecto para mostrar.

El flujo ejecuta el generador, compila la solución generada y crea un archivo ZIP con la carpeta del servicio.

### Uso desde GitHub Actions

1. Ve a la pestaña **Actions**.
2. Selecciona el workflow **Generate and ZIP service template**.
3. Haz clic en **Run workflow**.
4. Proporciona `service_name` y `project_name`.
5. Revisa el artifact ZIP en la ejecución finalizada.

### Resultado

El workflow sube un artifact ZIP llamado `<service_name>-project` con el contenido del proyecto generado.

### Scripts Incluidos

- `ms-build-generator.sh`: Script principal que orquesta la creación completa.
- `build-create.sh`: Crea la solución y proyectos base.
- `build-programs-default.sh`: Genera `Program.cs` personalizado para la API.
- `build-references.sh`: Agrega referencias entre proyectos.
- `build-packages.sh`: Instala paquetes NuGet necesarios.
- `build-api-helpers.sh`: Crea helpers para CORS y Swagger.
- `build-default-controllers.sh`: Genera controladores por defecto.
- `build-implementations.sh`: Crea implementaciones básicas de dominio y servicios.
- `build-infrastructure-folders.sh`: Configura carpetas de infraestructura.
- `build-docker-and-pipeline.sh`: Genera Dockerfile y pipeline de Azure DevOps.

## Personalización

- Modifica los scripts para ajustar paquetes, controladores o implementaciones según tus necesidades.
- El `Program.cs` generado incluye configuración básica; edítalo para agregar middlewares o servicios adicionales.
- Para bases de datos, agrega Entity Framework o Dapper en Infrastructure.

## Contribuir

1. Fork el repositorio.
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`).
3. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`).
4. Push a la rama (`git push origin feature/nueva-funcionalidad`).
5. Abre un Pull Request.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo LICENSE para más detalles.