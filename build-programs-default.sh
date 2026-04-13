#!/bin/bash

create_program_cs() {
  cat > src/"$SERVICE_NAME.Api"/Program.cs <<EOF
using $SERVICE_NAME.Api.Helpers;

var builder = WebApplication.CreateBuilder(args);

// 🔹 Configuración
builder.Configuration
    .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
    .AddJsonFile($"appsettings.{builder.Environment.EnvironmentName}.json", optional: true, reloadOnChange: true);

// 🔹 Servicios
builder.Services.AddControllers();
builder.Services.AddSwaggerGen();
builder.Services.AddSwaggerConfig(builder.Environment);

// Swagger (tu helper

var app = builder.Build();
app.UseSwagger(); 
app.UseSwaggerUI();
app.MapControllers();
app.Run();
EOF
}