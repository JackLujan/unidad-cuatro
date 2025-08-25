#  GameStore - Tienda de Videojuegos con JWT

##  Descripción
Aplicación web de tienda de videojuegos con sistema de autenticación JWT, login con Google y funcionalidades de compra.

##  Instalación y Configuración

### Opción 1: Instalación Local

#### 1. Instalar dependencias
```bash
npm install
```

#### 2. Configurar variables de entorno
Crear un archivo `.env` en la raíz del proyecto:
```env
GOOGLE_CLIENT_ID=tu_client_id_de_google
PORT=5500
JWT_SECRET=clave_secreta_videojuegos1234_super_segura
JWT_EXPIRES_IN=1h
```

#### 3. Iniciar el servidor
```bash
npm start
# o
node server.js
```

### Opción 2: Contenerización con Docker

#### 1. Configurar variables de entorno
Copiar el archivo `env.example` a `.env` y configurar:
```bash
cp env.example .env
# Editar .env con tus valores
```

#### 2. Construir y ejecutar con Docker Compose
```bash
# Construir y ejecutar
docker-compose up --build

# Ejecutar en segundo plano
docker-compose up -d

# Ver logs
docker-compose logs -f

# Detener servicios
docker-compose down
```

#### 3. Verificar funcionamiento
```bash
# Verificar contenedores
docker-compose ps

# Verificar logs
docker-compose logs web-app

# Probar health check
curl http://localhost:5500/api/health
```

##  Configuración del Puerto

### Cambiar el puerto del servidor
Para cambiar el puerto del servidor, edita el archivo `server.js`:

```javascript
const PORT = process.env.PORT || 5500;  // Cambia este número
```

### Cambiar el puerto del frontend
Para cambiar el puerto del frontend, edita el archivo `public/config.js`:

```javascript
const config = {
    apiBaseUrl: 'http://localhost:5500/api',  // Cambia este puerto
    serverUrl: 'http://localhost:5500'  // Cambia este puerto
};
```

##  Puertos por Defecto
- **Servidor Backend**: 5500 (configurable via PORT)
- **Frontend**: Se sirve desde el mismo puerto (5500)
- **Docker**: Mapeado al puerto 5500 del host

##  Funcionalidades de Autenticación
- Login con usuario/contraseña (admin/admin123)
- Login con Google OAuth2
- Tokens JWT para sesiones
- Rutas protegidas con middleware de autenticación

##  Endpoints del Carrito (RA-Unidad III)
Todos los endpoints requieren autenticación JWT:

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| `GET` | `/api/carrito` | Obtener carrito del usuario |
| `POST` | `/api/carrito/add` | Agregar producto al carrito |
| `PUT` | `/api/carrito/update/:productId` | Actualizar cantidad de un producto |
| `DELETE` | `/api/carrito/remove/:productId` | Eliminar producto del carrito |
| `DELETE` | `/api/carrito/clear` | Vaciar carrito completo |

### Flujo del Carrito
1. Realizar login y obtener token JWT
2. Consultar carrito vacío (GET /api/carrito)
3. Agregar productos (POST /api/carrito/add)
4. Modificar cantidades (PUT /api/carrito/update/:id)
5. Eliminar productos (DELETE /api/carrito/remove/:id)
6. Vaciar carrito (DELETE /api/carrito/clear)
7. Confirmar carrito vacío

## Funcionalidades de la Tienda
- Catálogo de videojuegos
- Sistema de filtros (género, precio, búsqueda)
- **Sistema completo de carrito de compras con endpoints REST**
- Procesamiento de compras
- Perfil de usuario con saldo y historial

## Estructura del Proyecto
```
JWT-Token/
├── config/
│   ├── jwtConfig.js          # Configuración JWT
│   └── serverConfig.js       # Configuración del servidor
├── controllers/
│   ├── authController.js     # Controlador de autenticación
│   ├── cartController.js     # Controlador del carrito
│   ├── juegosController.js   # Controlador de juegos
│   └── perfilController.js   # Controlador de perfil
├── middlewares/
│   └── authMiddleware.js     # Middleware de autenticación
├── public/                   # Archivos estáticos del frontend
├── routes/                   # Definición de rutas API
├── Dockerfile               # Configuración para contenerización
├── docker-compose.yml       # Orquestación de servicios Docker
├── .dockerignore            # Archivos excluidos del contenedor
└── env.example              # Ejemplo de variables de entorno
├── models/
│   ├── cartModel.js          # Modelo del carrito
│   └── userModel.js          # Modelo de usuario
├── public/
│   ├── config.js            # Configuración del frontend
│   ├── index.html           # Página de login
│   ├── tienda.html          # Página de la tienda
│   └── test-carrito.html    # Página de prueba del carrito
├── routes/
│   ├── authRoutes.js        # Rutas de autenticación
│   └── protectedRoutes.js   # Rutas protegidas
├── server.js                # Servidor principal
└── package.json
```

## Comandos Útiles

### Iniciar en modo desarrollo
```bash
npm run dev
```

### Verificar sintaxis
```bash

## Probar el Sistema de Carrito

### Opción 1: Página de Prueba
1. Inicia el servidor: `npm start`
2. Ve a: `http://localhost:5500/test-carrito.html`
3. Haz login con `admin/admin123`
4. Ejecuta el test completo para verificar todos los endpoints

### Opción 2: Tienda Principal
1. Inicia el servidor: `npm start`
2. Ve a: `http://localhost:5500/index.html`
3. Haz login y navega a la tienda
4. Usa las funcionalidades del carrito integradas

### Opción 3: API Directa
Puedes probar los endpoints directamente con herramientas como Postman o curl:

```bash
# Login
curl -X POST http://localhost:5500/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin123"}'

# Obtener carrito (usa el token del login)
curl -X GET http://localhost:5500/api/carrito \
  -H "Authorization: Bearer TU_TOKEN_AQUI"
```
node -c server.js
```

### Revisar puertos en uso
```bash
netstat -an | findstr :5500
```

## Notas Importantes
- El servidor debe estar corriendo para que funcione la autenticación
- Las rutas de la API están protegidas con JWT
- El login con Google requiere configuración de OAuth2 válida
- Los datos de usuario son simulados (no hay base de datos real)

## Solución de Problemas

### Error de CORS
Si tienes problemas de CORS, verifica que el servidor esté corriendo en el puerto correcto.

### Error de Autenticación
Verifica que el token JWT esté presente en localStorage y no haya expirado.

### Puerto ya en uso
Si el puerto 5500 está ocupado, cambia la configuración en `config/serverConfig.js`.

