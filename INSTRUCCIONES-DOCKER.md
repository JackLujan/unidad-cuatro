#  Instrucciones de Contenerización - JWT-Token GameStore

##  Resumen del Proceso Realizado

### 1.  Dockerfile Creado
- **Ubicación**: `./Dockerfile`
- **Base**: Node.js 18 Alpine (imagen ligera)
- **Puerto**: 5500
- **Comando**: `npm start`

### 2.  Docker Compose Configurado
- **Archivo**: `./docker-compose.yml`
- **Servicio**: `web-app`
- **Puerto**: 5500:5500 (host:contenedor)
- **Variables de entorno**: Configuradas desde archivo .env
- **Health check**: Endpoint `/api/health`

### 3.  Variables de Entorno Configuradas
- **Archivo**: `./env.example` (copia a `.env`)
- **Variables principales**:
  - `JWT_SECRET`: Clave secreta para firmar tokens
  - `GOOGLE_CLIENT_ID`: ID de cliente de Google OAuth
  - `PORT`: Puerto del servidor (5500)
  - `NODE_ENV`: Entorno de producción

### 4.  Configuración JWT Actualizada
- **Archivo**: `./config/jwtConfig.js`
- **Cambios**: Ahora usa variables de entorno
- **Fallback**: Valores por defecto si no hay variables

### 5.  Endpoint de Health Check
- **Ruta**: `GET /api/health`
- **Propósito**: Verificar estado del contenedor
- **Respuesta**: Status, timestamp y uptime

##  Pasos para Ejecutar

### Paso 1: Preparar Variables de Entorno
```bash
# Copiar archivo de ejemplo
cp env.example .env

# Editar .env con tus valores reales
# Especialmente GOOGLE_CLIENT_ID para OAuth
```

### Paso 2: Construir y Ejecutar
```bash
# Construir imagen y ejecutar contenedores
docker-compose up --build

# O ejecutar en segundo plano
docker-compose up --build -d
```

### Paso 3: Verificar Funcionamiento
```bash
# Ver estado de contenedores
docker-compose ps

# Ver logs en tiempo real
docker-compose logs -f web-app

# Probar health check
curl http://localhost:5500/api/health
```

### Paso 4: Acceder a la Aplicación
- **URL**: http://localhost:5500
- **API**: http://localhost:5500/api
- **Health**: http://localhost:5500/api/health

##  Pruebas de Funcionamiento

### 1. Pruebas Básicas
-  Aplicación accesible en navegador
-  Health check responde correctamente
-  Contenedor ejecutándose sin errores

### 2. Pruebas de Autenticación
-  Login normal (admin/admin123)
-  Generación de tokens JWT
-  Login con Google OAuth (requiere configuración)

### 3. Pruebas de API
-  Endpoints protegidos con JWT
-  Carrito de compras funcional
-  Middleware de autenticación

## Comandos Docker Útiles

```bash
# Ver logs
docker-compose logs -f

# Reiniciar servicio
docker-compose restart web-app

# Reconstruir y ejecutar
docker-compose up --build

# Detener servicios
docker-compose down

# Ver uso de recursos
docker stats

# Entrar al contenedor
docker-compose exec web-app sh
```

## Monitoreo y Debugging

### Health Check
- **Endpoint**: `/api/health`
- **Intervalo**: 30 segundos
- **Timeout**: 10 segundos
- **Reintentos**: 3

### Logs
- **Acceso**: `docker-compose logs -f web-app`
- **Nivel**: Info, Warn, Error
- **Persistencia**: Volumen montado en `./logs`

## Solución de Problemas

### Error: Puerto 5500 ocupado
```bash
# Cambiar puerto en docker-compose.yml
ports:
  - "5501:5500"  # Usar puerto 5501 del host
```

### Error: Variables de entorno no cargadas
```bash
# Verificar archivo .env existe
ls -la .env

# Verificar variables en contenedor
docker-compose exec web-app env | grep JWT
```

### Error: Contenedor no inicia
```bash
# Ver logs detallados
docker-compose logs web-app

# Verificar dependencias
docker-compose exec web-app npm list
```

##  Notas Importantes

1. **Google OAuth**: Requiere configuración real de `GOOGLE_CLIENT_ID`
2. **JWT Secret**: Cambiar en producción por seguridad
3. **Puerto**: Configurable via variable `PORT`
4. **Persistencia**: Logs se guardan en volumen `./logs`
5. **Health Check**: Necesario para orquestación de contenedores

##  Evidencias de Funcionamiento

### Terminal
-  `docker-compose up --build` sin errores
-  Contenedores en estado "Up"
-  Health check exitoso

### Navegador
-  Aplicación accesible en http://localhost:3000
-  Interfaz de usuario funcional
-  Login y autenticación funcionando

### API
-  Endpoints respondiendo correctamente
-  Tokens JWT generándose
-  Autenticación OAuth configurada

##  Enlaces Útiles

- **Docker Hub**: https://hub.docker.com/
- **Docker Compose**: https://docs.docker.com/compose/
- **Node.js Docker**: https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
- **JWT**: https://jwt.io/
- **Google OAuth**: https://developers.google.com/identity/protocols/oauth2
