#!/bin/bash

create_domain_and_service_implementations() {
  mkdir -p src/"$SERVICE_NAME.Domain"/Implementations
  mkdir -p src/"$SERVICE_NAME.Application"/Implementations

  cat > src/"$SERVICE_NAME.Domain"/Implementations/HealthDomain.cs <<EOF
namespace $SERVICE_NAME.Domain.Implementations
{
    public class HealthDomain
    {
        public string GetStatus() => "Healthy";
    }
}
EOF

  cat > src/"$SERVICE_NAME.Application"/Implementations/HealthService.cs <<EOF
using $SERVICE_NAME.Domain.Implementations;

namespace $SERVICE_NAME.Application.Implementations
{
    public class HealthService
    {
        private readonly HealthDomain _healthDomain;

        public HealthService()
        {
            _healthDomain = new HealthDomain();
        }

        public string GetHealthStatus() => _healthDomain.GetStatus();
    }
}
EOF
}
