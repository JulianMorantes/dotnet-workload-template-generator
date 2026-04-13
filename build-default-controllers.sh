#!/bin/bash

create_default_controllers() {
  mkdir -p src/"$SERVICE_NAME.Api"/Controllers

  cat > src/"$SERVICE_NAME.Api"/Controllers/HealthController.cs <<EOF
using Microsoft.AspNetCore.Mvc;

namespace $SERVICE_NAME.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class HealthController : ControllerBase
    {
        [HttpGet]
        public IActionResult Get() => Ok(new { status = "Healthy" });
    }
}
EOF

  cat > src/"$SERVICE_NAME.Api"/Controllers/AuthenticationController.cs <<EOF
using Microsoft.AspNetCore.Mvc;

namespace $SERVICE_NAME.Api.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthenticationController : ControllerBase
    {
        [HttpPost("login")]
        public IActionResult Login()
        {
            // Añade tu lógica de autenticación aquí.
            return Ok(new { token = "token-aqui" });
        }
    }
}
EOF
}
