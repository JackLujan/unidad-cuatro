#!/bin/bash

echo " Iniciando pruebas de Docker para JWT-Token GameStore"
echo "=================================================="

# Verificar que Docker esté ejecutándose
echo "1. Verificando Docker..."
if ! docker info > /dev/null 2>&1; then
    echo " Docker no está ejecutándose. Inicia Docker y vuelve a intentar."
    exit 1
fi
echo " Docker está ejecutándose"

# Verificar que Docker Compose esté disponible
echo "2. Verificando Docker Compose..."
if ! docker-compose --version > /dev/null 2>&1; then
    echo " Docker Compose no está disponible."
    exit 1
fi
echo " Docker Compose está disponible"

# Construir y ejecutar la aplicación
echo "3. Construyendo y ejecutando la aplicación..."
docker-compose up --build -d

# Esperar a que la aplicación esté lista
echo "4. Esperando a que la aplicación esté lista..."
sleep 10

# Verificar el estado de los contenedores
echo "5. Verificando estado de los contenedores..."
docker-compose ps

# Probar el health check
echo "6. Probando health check..."
if curl -f http://localhost:5500/api/health > /dev/null 2>&1; then
    echo " Health check exitoso"
else
    echo " Health check falló"
fi

# Probar la página principal
echo "7. Probando página principal..."
if curl -f http://localhost:5500 > /dev/null 2>&1; then
    echo " Página principal accesible"
else
    echo " Página principal no accesible"
fi

echo ""
echo " Pruebas completadas!"
echo " Accede a http://localhost:5500 en tu navegador"
echo " Para ver logs: docker-compose logs -f web-app"
echo " Para detener: docker-compose down"
