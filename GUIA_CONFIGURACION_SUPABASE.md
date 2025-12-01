# 🔧 Guía Completa: Configuración de Supabase

Esta guía te llevará paso a paso para configurar Supabase en tu proyecto Flutter.

## 📋 Tabla de Contenidos

1. [Crear cuenta y proyecto en Supabase](#1-crear-cuenta-y-proyecto-en-supabase)
2. [Obtener credenciales de API](#2-obtener-credenciales-de-api)
3. [Configurar credenciales en Flutter](#3-configurar-credenciales-en-flutter)
4. [Configurar la base de datos](#4-configurar-la-base-de-datos)
5. [Configurar Storage para imágenes](#5-configurar-storage-para-imágenes)
6. [Verificar la configuración](#6-verificar-la-configuración)

---

## 1. Crear cuenta y proyecto en Supabase

### Paso 1.1: Crear cuenta
1. Ve a [https://supabase.com](https://supabase.com)
2. Haz clic en **"Start your project"** o **"Sign in"**
3. Puedes registrarte con:
   - GitHub
   - Google
   - Email

### Paso 1.2: Crear nuevo proyecto
1. Una vez dentro del dashboard, haz clic en **"New Project"**
2. Completa el formulario:
   - **Name**: `marketplace-artesanal` (o el nombre que prefieras)
   - **Database Password**: Crea una contraseña segura (¡guárdala bien!)
   - **Region**: Elige la región más cercana a tus usuarios
   - **Pricing Plan**: Selecciona **Free** para empezar
3. Haz clic en **"Create new project"**
4. Espera 2-3 minutos mientras se crea el proyecto

---

## 2. Obtener credenciales de API

### Paso 2.1: Acceder a la configuración de API
1. En el dashboard de Supabase, en el menú lateral izquierdo, busca **"Settings"** (⚙️)
2. Haz clic en **"API"** dentro de Settings

### Paso 2.2: Copiar las credenciales
Verás dos valores importantes:

1. **Project URL**
   - Se encuentra en la sección **"Project URL"**
   - Ejemplo: `https://xxxxxxxxxxxxx.supabase.co`
   - Haz clic en el ícono de copiar 📋

2. **anon public key**
   - Se encuentra en la sección **"Project API keys"**
   - Busca la clave **"anon"** o **"public"**
   - Es una cadena larga que comienza con `eyJ...`
   - Haz clic en el ícono de copiar 📋

⚠️ **IMPORTANTE**: 
- La clave **anon/public** es segura para usar en el cliente (Flutter)
- **NUNCA** uses la clave **service_role** en el cliente, es solo para el servidor

---

## 3. Configurar credenciales en Flutter

### Paso 3.1: Abrir el archivo de configuración
1. En tu proyecto Flutter, abre el archivo:
   ```
   lib/config/supabase_config.dart
   ```

### Paso 3.2: Reemplazar los valores
Encuentra estas líneas:
```dart
static const String supabaseUrl = 'TU_SUPABASE_URL';
static const String supabaseAnonKey = 'TU_SUPABASE_ANON_KEY';
```

Reemplázalas con tus credenciales:
```dart
static const String supabaseUrl = 'https://xxxxxxxxxxxxx.supabase.co';
static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
```

**Ejemplo completo:**
```dart
class SupabaseConfig {
  static const String supabaseUrl = 'https://abcdefghijklmnop.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFiY2RlZmdoaWprbG1ub3AiLCJyb2xlIjoiYW5vbiIsImlhdCI6MTYzODk2NzI5MCwiZXhwIjoxOTU0NTQzMjkwfQ.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';
  
  // ... resto del código
}
```

### Paso 3.3: Guardar el archivo
Guarda los cambios (Ctrl+S o Cmd+S)

---

## 4. Configurar la base de datos

### Paso 4.1: Abrir el SQL Editor
1. En el dashboard de Supabase, en el menú lateral, haz clic en **"SQL Editor"**
2. Haz clic en **"New query"**

### Paso 4.2: Ejecutar el esquema SQL
1. Abre el archivo `supabase_schema.sql` en tu proyecto Flutter
2. Copia **TODO** el contenido del archivo
3. Pégalo en el editor SQL de Supabase
4. Haz clic en **"Run"** (o presiona Ctrl+Enter)

### Paso 4.3: Verificar que se crearon las tablas
1. En el menú lateral, ve a **"Table Editor"**
2. Deberías ver dos tablas:
   - ✅ `profiles`
   - ✅ `products`

Si ves ambas tablas, ¡la base de datos está configurada correctamente!

---

## 5. Configurar Storage para imágenes

### Paso 5.1: Crear el bucket
1. En el dashboard de Supabase, en el menú lateral, haz clic en **"Storage"**
2. Haz clic en **"Create a new bucket"**
3. Configura el bucket:
   - **Name**: `product-images` (exactamente así, sin espacios)
   - **Public bucket**: ✅ **Marca esta casilla** (permite acceso público a las imágenes)
4. Haz clic en **"Create bucket"**

### Paso 5.2: Configurar políticas de Storage (Opcional pero recomendado)
1. Haz clic en el bucket `product-images` que acabas de crear
2. Ve a la pestaña **"Policies"**
3. Haz clic en **"New Policy"**
4. Selecciona **"Create a policy from scratch"**
5. Configura:
   - **Policy name**: `Allow authenticated uploads`
   - **Allowed operations**: Marca **INSERT** y **UPDATE**
   - **Policy definition**: 
     ```sql
     (bucket_id = 'product-images'::text) AND (auth.role() = 'authenticated'::text)
     ```
6. Haz clic en **"Review"** y luego **"Save policy"**

### Paso 5.3: Verificar el bucket
Deberías ver el bucket `product-images` en la lista de buckets con el estado **"Public"**

---

## 6. Verificar la configuración

### Paso 6.1: Verificar en el código
Abre `lib/config/supabase_config.dart` y verifica que:
- ✅ `supabaseUrl` tiene tu URL de Supabase
- ✅ `supabaseAnonKey` tiene tu clave anon
- ✅ No hay espacios extra o comillas incorrectas

### Paso 6.2: Probar la conexión
1. Ejecuta la aplicación:
   ```bash
   flutter run
   ```
2. Intenta registrarte con un nuevo usuario
3. Si funciona, verás la pantalla de productos

### Paso 6.3: Verificar en Supabase
1. Ve a **"Authentication" > "Users"** en Supabase
2. Deberías ver el usuario que acabas de crear
3. Ve a **"Table Editor" > "profiles"**
4. Deberías ver el perfil del usuario

---

## ✅ Checklist de Configuración

Marca cada paso cuando lo completes:

- [ ] Cuenta creada en Supabase
- [ ] Proyecto creado en Supabase
- [ ] Credenciales copiadas (URL y anon key)
- [ ] Credenciales configuradas en `lib/config/supabase_config.dart`
- [ ] Esquema SQL ejecutado en Supabase
- [ ] Tablas `profiles` y `products` creadas
- [ ] Bucket `product-images` creado en Storage
- [ ] Aplicación ejecutándose sin errores
- [ ] Usuario de prueba creado exitosamente

---

## 🐛 Solución de Problemas

### Error: "Invalid API key"
- **Causa**: La clave anon está incorrecta o tiene espacios extra
- **Solución**: Verifica que copiaste la clave completa sin espacios

### Error: "relation does not exist"
- **Causa**: No ejecutaste el esquema SQL
- **Solución**: Ve al SQL Editor y ejecuta el contenido de `supabase_schema.sql`

### Error: "bucket not found"
- **Causa**: El bucket no existe o tiene otro nombre
- **Solución**: Verifica que el bucket se llama exactamente `product-images`

### Error: "permission denied"
- **Causa**: Las políticas RLS están bloqueando la operación
- **Solución**: Verifica que ejecutaste todo el SQL, incluyendo las políticas

### La app se cierra al iniciar
- **Causa**: Error en la inicialización de Supabase
- **Solución**: 
  1. Verifica las credenciales en `supabase_config.dart`
  2. Revisa la consola para ver el error específico
  3. Asegúrate de que el proyecto de Supabase esté activo

---

## 📞 ¿Necesitas ayuda?

Si tienes problemas:
1. Revisa los logs de la aplicación en la consola
2. Revisa los logs en Supabase: **"Logs" > "API Logs"**
3. Verifica que todas las dependencias estén instaladas: `flutter pub get`

---

## 🎉 ¡Listo!

Una vez completados todos los pasos, tu aplicación estará lista para usar. Podrás:
- ✅ Registrar usuarios
- ✅ Iniciar sesión
- ✅ Crear productos
- ✅ Ver productos
- ✅ Editar productos
- ✅ Eliminar productos

¡Disfruta tu marketplace artesanal! 🛍️

