# 📥 Guía: Importar Datos de Ejemplo en Supabase

Esta guía te ayudará a importar datos de ejemplo en tus tablas de Supabase para probar la aplicación.

## 📋 Archivos de Datos Incluidos

1. **`datos_ejemplo/profiles.csv`** - Datos de ejemplo para la tabla `profiles` (CSV)
2. **`datos_ejemplo/products.csv`** - Datos de ejemplo para la tabla `products` (CSV)
3. **`datos_ejemplo/insertar_datos_ejemplo.sql`** - Script SQL para insertar productos (⭐ RECOMENDADO)

---

## ⚠️ IMPORTANTE: Antes de Importar

### 1. Los IDs en los CSV son de Ejemplo

Los UUIDs en los archivos CSV son **solo para referencia**. Cuando importes en Supabase:

- **Para `profiles`**: Los IDs deben corresponder a usuarios reales creados en Supabase Auth
- **Para `products`**: Los `seller_id` deben corresponder a IDs reales de la tabla `profiles`

### 2. Opciones de Importación

Tienes tres opciones:

**Opción A: Usar Script SQL (⭐ MÁS FÁCIL)**
- Crear usuarios en Supabase Auth
- Ejecutar el script SQL que busca usuarios por email
- No necesitas ajustar IDs manualmente

**Opción B: Crear manualmente desde la app**
- Crear usuarios manualmente en Supabase Auth
- Crear productos desde la aplicación

**Opción C: Importar CSV (Requiere ajustes)**
- Ajustar los IDs en los CSV
- Importar usando el Table Editor de Supabase

---

## 🔧 Opción A: Usar Script SQL (⭐ RECOMENDADO)

### Paso 1: Crear Usuarios en Supabase Auth

1. Ve a **Authentication > Users** en Supabase
2. Haz clic en **"Add user"** o **"Invite user"**
3. Crea los siguientes usuarios de prueba:

```
Email: maria.artesana@example.com
Password: password123
Email: juan.joyero@example.com
Password: password123
Email: ana.textil@example.com
Password: password123
Email: carlos.comprador@example.com
Password: password123
Email: laura.comprador@example.com
Password: password123
Email: admin@marketplace.com
Password: admin123
```

### Paso 2: Completar Perfiles (Opcional)

Los perfiles se crean automáticamente cuando los usuarios se registran. Si quieres actualizar la información:

1. Inicia sesión en la app con cada usuario
2. Completa el perfil con la información
3. O ejecuta UPDATEs en SQL Editor (ver script SQL)

### Paso 3: Ejecutar Script SQL para Productos

1. Ve a **SQL Editor** en Supabase
2. Abre el archivo `datos_ejemplo/insertar_datos_ejemplo.sql`
3. Copia TODO el contenido
4. Pega en el SQL Editor
5. Haz clic en **"Run"**

El script automáticamente:
- Busca los usuarios por email
- Inserta los productos con los seller_id correctos
- Actualiza seller_name y seller_whatsapp automáticamente (gracias a los triggers)

### Paso 4: Verificar

1. Ve a **Table Editor > products**
2. Deberías ver 10 productos
3. Verifica que los datos estén correctos

---

## 🔧 Opción B: Crear Datos Manualmente

### Paso 1: Crear Usuarios en Supabase Auth

1. Ve a **Authentication > Users** en Supabase
2. Haz clic en **"Add user"** o **"Invite user"**
3. Crea los siguientes usuarios de prueba:

```
Email: maria.artesana@example.com
Password: password123
Email: juan.joyero@example.com
Password: password123
Email: ana.textil@example.com
Password: password123
Email: carlos.comprador@example.com
Password: password123
Email: laura.comprador@example.com
Password: password123
Email: admin@marketplace.com
Password: admin123
```

### Paso 2: Completar Perfiles

1. Inicia sesión en la app con cada usuario
2. Completa el perfil con la información del CSV
3. O edita directamente en **Table Editor > profiles**

### Paso 3: Crear Productos

1. Inicia sesión como vendedor (maria, juan, o ana)
2. Crea productos usando la información del CSV
3. O importa directamente (ver Opción B)

---

## 📥 Opción B: Importar CSV Directamente

### Paso 1: Preparar los CSV

Los archivos CSV ya están listos, pero necesitas ajustar los IDs:

1. Abre `datos_ejemplo/profiles.csv`
2. Reemplaza los IDs con los IDs reales de tus usuarios en Supabase Auth
3. Abre `datos_ejemplo/products.csv`
4. Reemplaza los `seller_id` con los IDs reales de la tabla `profiles`

### Paso 2: Importar en Supabase

#### Para la tabla `profiles`:

1. Ve a **Table Editor > profiles**
2. Haz clic en el botón **"Insert"** o **"..."** (menú)
3. Selecciona **"Import data"** o **"Import CSV"**
4. Sube el archivo `profiles.csv`
5. Mapea las columnas correctamente
6. Haz clic en **"Import"**

#### Para la tabla `products`:

1. Ve a **Table Editor > products**
2. Haz clic en el botón **"Insert"** o **"..."** (menú)
3. Selecciona **"Import data"** o **"Import CSV"**
4. Sube el archivo `products.csv`
5. Mapea las columnas correctamente
6. Haz clic en **"Import"**

---

## 📊 Datos de Ejemplo Incluidos

### Usuarios (profiles.csv)

- **3 Vendedores:**
  - María González (Artesanías y Cerámica)
  - Juan Pérez (Joyería)
  - Ana Martínez (Textiles)

- **2 Compradores:**
  - Carlos Rodríguez
  - Laura Sánchez

- **1 Administrador:**
  - Admin (email: admin@marketplace.com)

### Productos (products.csv)

- **10 Productos de ejemplo:**
  - Macramé Decorativo (Artesanías) - $450
  - Collar de Plata 925 (Joyería) - $850
  - Chal Artesanal (Textiles) - $320
  - Jarrón de Cerámica (Cerámica) - $280
  - Anillos de Acero (Joyería) - $150
  - Bolsa de Tela Ecológica (Textiles) - $120
  - Plato Decorativo (Cerámica) - $180
  - Pulsera de Cuentas (Joyería) - $95
  - Almohada Decorativa (Textiles) - $250
  - Porta Velas (Cerámica) - $200

---

## 🔍 Verificar la Importación

### Verificar Profiles:

1. Ve a **Table Editor > profiles**
2. Deberías ver 6 registros
3. Verifica que los emails y datos estén correctos

### Verificar Products:

1. Ve a **Table Editor > products**
2. Deberías ver 10 registros
3. Verifica que los `seller_id` correspondan a IDs reales en `profiles`

---

## ⚠️ Problemas Comunes

### Error: "Foreign key constraint"
- **Causa**: Los `seller_id` en products no existen en profiles
- **Solución**: Asegúrate de que los IDs en products correspondan a IDs reales en profiles

### Error: "Invalid UUID format"
- **Causa**: Los IDs no están en formato UUID válido
- **Solución**: Usa los IDs reales generados por Supabase

### Error: "Duplicate key"
- **Causa**: Intentas insertar un ID que ya existe
- **Solución**: Elimina los registros existentes o usa IDs diferentes

---

## 💡 Consejos

1. **Para pruebas rápidas**: Usa la Opción A (crear manualmente desde la app)
2. **Para muchos datos**: Usa la Opción B (importar CSV)
3. **Para producción**: No uses estos datos, crea datos reales

---

## 🎯 Próximos Pasos

Una vez importados los datos:

1. ✅ Verifica que los datos se importaron correctamente
2. ✅ Inicia sesión en la app con los usuarios de prueba
3. ✅ Prueba todas las funcionalidades:
   - Ver productos
   - Buscar y filtrar
   - Crear productos (como vendedor)
   - Editar productos
   - Contactar vendedor
   - Ver perfil

---

¡Listo! Ahora tienes datos de ejemplo para probar tu marketplace. 🎉

