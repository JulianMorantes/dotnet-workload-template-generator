#!/bin/bash

create_api_helpers() {
  mkdir -p src/"$SERVICE_NAME.Api"/Helpers

  cat > src/"$SERVICE_NAME.Api"/Helpers/CorsConfig.cs <<EOF
using Microsoft.Extensions.DependencyInjection;

namespace $SERVICE_NAME.Api.Helpers
{
    public static class CorsConfig
    {
        public static IServiceCollection AddCoresConfigurations(this IServiceCollection services)
        {
            var namePolice = "MsApiPolicy";
            services.AddCors(options =>
            {
                options.AddPolicy(namePolice, policy =>
                {
                    policy.WithOrigins("*")
                        .AllowAnyHeader()
                        .AllowAnyMethod();
                });
            });
            return services;
        }
    }
}
EOF

  cat > src/"$SERVICE_NAME.Api"/Helpers/SwaggerConfig.cs <<EOF
using Microsoft.OpenApi;

namespace $SERVICE_NAME.Api.Helpers
{
    public static class SwaggerConfig
    {
        public static IServiceCollection AddSwaggerConfig(this IServiceCollection services, IWebHostEnvironment env)
        {
            services.AddSwaggerGen(option =>
            {
                option.SwaggerDoc("v1", new OpenApiInfo { Title = "Ms Project $SERVICE_NAME Microservice", Version = "v1" });
                option.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
                {
                    Name = "Authorization",
                    Type = SecuritySchemeType.Http,
                    Scheme = "bearer",
                    BearerFormat = "JWT",
                    In = ParameterLocation.Header,
                    Description = "Please enter token"
                });

                // Security Requirement（use Transformer）
                option.AddSecurityRequirement(document =>
                    new OpenApiSecurityRequirement
                    {
                        [new OpenApiSecuritySchemeReference("Bearer", document)] = []
                    });

                if (env.IsProduction())
                {
                    option.AddServer(new OpenApiServer { Url = "/ms_project_auth.Api" });
                }
            });

            return services;
        }
    }
}
EOF

  cat > src/"$SERVICE_NAME.Api"/Helpers/MapperConfig.cs <<EOF
using AutoMapper;

namespace $SERVICE_NAME.Api.Helpers
{
    public class MapperConfig : Profile
    {
        public MapperConfig()
        {
            //CreateMap<User, UserDto>();
            //CreateMap<UserDto, User>();
        }
    }
}
EOF
}
