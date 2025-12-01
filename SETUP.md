# Configuración del Marketplace Artesanal

## Pasos para configurar el proyecto

### 1. Configurar Supabase

1. Crea una cuenta en [Supabase](https://supabase.com)
2. Crea un nuevo proyecto
3. Ve a **Settings > API** y copia:
   - **Project URL**
   - **anon/public key**

### 2. Configurar credenciales en Flutter

1. Abre el archivo `lib/config/supabase_config.dart`
2. Reemplaza los valores:
   ```dart
   static const String supabaseUrl = 'TU_SUPABASE_URL';
   static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY';
   ```

### 3. Configurar la base de datos

1. En el dashboard de Supabase, ve a **SQL Editor**
2. Copia y ejecuta el contenido del archivo `supabase_schema.sql`
3. Esto creará las tablas necesarias y las políticas de seguridad

### 4. Configurar Storage para imágenes

1. En Supabase, ve a **Storage**
2. Crea un nuevo bucket llamado `product-images`
3. Configura las políticas:
   - **Public Access**: Habilitado (o configura políticas específicas)
   - **File size limit**: 5MB
   - **Allowed MIME types**: image/jpeg, image/png, image/webp

### 5. Instalar dependencias

Ejecuta en la terminal:
```bash
flutter pub get
```

### 6. Ejecutar la aplicación

```bash
flutter run
```

## Estructura del proyecto

```
lib/
├── config/
│   └── supabase_config.dart      # Configuración de Supabase
├── models/
│   ├── user_model.dart            # Modelo de usuario
│   └── product_model.dart         # Modelo de producto
├── services/
│   ├── auth_service.dart          # Servicio de autenticación
│   └── product_service.dart       # Servicio de productos (CRUD)
├── providers/
│   ├── auth_provider.dart         # Provider de autenticación
│   └── product_provider.dart      # Provider de productos
└── screens/
    ├── auth/
    │   ├── login_screen.dart      # Pantalla de login
    │   └── register_screen.dart   # Pantalla de registro
    └── products/
        ├── product_list_screen.dart    # Lista de productos
        ├── product_detail_screen.dart # Detalle de producto
        └── product_form_screen.dart    # Crear/Editar producto
```

## Funcionalidades implementadas

### ✅ Autenticación
- Registro de usuarios (vendedores y compradores)
- Login
- Logout
- Gestión de sesión

### ✅ CRUD de Productos
- **Crear**: Los vendedores pueden crear productos con imágenes
- **Leer**: Lista de productos con búsqueda y filtros por categoría
- **Actualizar**: Los vendedores pueden editar sus productos
- **Eliminar**: Soft delete (marcar como inactivo)

### Características adicionales
- Búsqueda de productos
- Filtrado por categorías
- Vista de detalle de producto
- Contacto con vendedor por WhatsApp
- Interfaz moderna y responsive

## Próximos pasos (50% restante)

- [ ] Búsqueda avanzada con múltiples filtros
- [ ] Perfil de vendedor con información de contacto
- [ ] Notificaciones push
- [ ] Panel de administración
- [ ] Sistema de favoritos
- [ ] Comentarios y valoraciones
- [ ] Historial de productos vistos

## Notas importantes

- Las imágenes se suben a Supabase Storage (configura el bucket primero)
- Los productos eliminados se marcan como inactivos (soft delete)
- Solo los vendedores pueden crear y editar productos
- Todos los usuarios pueden ver productos activos

