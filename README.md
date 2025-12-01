# Marketplace de Productos Artesanales y Emprendimientos

Una aplicación Flutter para un marketplace donde vendedores publican productos artesanales con fotos y descripciones, mientras los compradores descubren, buscan por categorías y contactan a los vendedores.

## 🚀 Características Implementadas (50%)

### Autenticación
- ✅ Registro de usuarios (vendedores y compradores)
- ✅ Login y logout
- ✅ Gestión de sesión persistente

### CRUD de Productos
- ✅ **Crear**: Los vendedores pueden crear productos con imágenes
- ✅ **Leer**: Lista de productos con búsqueda y filtros por categoría
- ✅ **Actualizar**: Los vendedores pueden editar sus productos
- ✅ **Eliminar**: Soft delete (marcar como inactivo)

### Funcionalidades Adicionales
- ✅ Búsqueda de productos por título y descripción
- ✅ Filtrado por categorías (Artesanías, Joyería, Textiles, Cerámica, Otros)
- ✅ Vista detallada de productos
- ✅ Contacto con vendedor por WhatsApp
- ✅ Interfaz moderna y responsive

## 📋 Próximas Funcionalidades (50% restante)

- [ ] Perfil de vendedor con información de contacto
- [ ] Notificaciones push
- [ ] Panel de administración básico para moderar publicaciones
- [ ] Sistema de favoritos
- [ ] Comentarios y valoraciones
- [ ] Historial de productos vistos

## 🛠️ Tecnologías Utilizadas

- **Flutter**: Framework de desarrollo móvil
- **Supabase**: Backend como servicio (BaaS)
  - Autenticación
  - Base de datos PostgreSQL
  - Storage para imágenes
- **Provider**: Gestión de estado
- **Image Picker**: Selección de imágenes
- **URL Launcher**: Integración con WhatsApp

## 📦 Instalación

1. Clona el repositorio
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Configura Supabase siguiendo las instrucciones en [SETUP.md](SETUP.md)
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## ⚙️ Configuración

Consulta el archivo [SETUP.md](SETUP.md) para instrucciones detalladas de configuración, incluyendo:
- Configuración de Supabase
- Esquema de base de datos
- Configuración de Storage
- Variables de entorno

## 📁 Estructura del Proyecto

```
lib/
├── config/           # Configuración (Supabase)
├── models/           # Modelos de datos
├── services/         # Servicios (Auth, Products)
├── providers/        # Providers de estado
└── screens/          # Pantallas de la aplicación
    ├── auth/         # Login y Registro
    └── products/     # Lista, Detalle, Formulario
```

## 📝 Licencia

Este proyecto es parte de un proyecto educativo.
