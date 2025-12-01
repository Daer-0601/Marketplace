# 📋 Guía: Crear Tablas en Supabase

## 🎯 Objetivo
Ejecutar el SQL para crear las tablas `profiles` y `products` en tu base de datos Supabase.

---

## 📝 Pasos Detallados

### Paso 1: Abrir SQL Editor en Supabase

1. Ve a tu dashboard de Supabase:
   - https://supabase.com/dashboard
   - Inicia sesión si es necesario

2. Selecciona tu proyecto:
   - Busca el proyecto con ID: `riifvjrfcynrtbkfeoyq`
   - O el proyecto que creaste para este marketplace

3. En el menú lateral izquierdo, busca y haz clic en **"SQL Editor"**
   - Está en la sección de herramientas
   - Tiene un ícono de código `</>`

### Paso 2: Crear Nueva Consulta

1. En el SQL Editor, haz clic en el botón **"New query"** (arriba a la izquierda)
2. Se abrirá un editor de código SQL en blanco

### Paso 3: Copiar el SQL

1. Abre el archivo `supabase_schema.sql` en tu proyecto Flutter
2. **Selecciona TODO el contenido** del archivo (Ctrl+A)
3. **Copia** el contenido (Ctrl+C)

### Paso 4: Pegar y Ejecutar

1. En el SQL Editor de Supabase, **pega** el contenido (Ctrl+V)
2. Verifica que el SQL se vea completo en el editor
3. Haz clic en el botón **"Run"** (o presiona **Ctrl+Enter**)
4. Espera unos segundos mientras se ejecuta

### Paso 5: Verificar que se Crearon las Tablas

1. En el menú lateral, haz clic en **"Table Editor"**
2. Deberías ver dos tablas nuevas:
   - ✅ **profiles** - Tabla de perfiles de usuario
   - ✅ **products** - Tabla de productos

Si ves ambas tablas, ¡las tablas se crearon correctamente! 🎉

---

## 🔍 Verificación Adicional

### Verificar Estructura de las Tablas

1. En **Table Editor**, haz clic en la tabla **"profiles"**
2. Deberías ver columnas como:
   - `id`, `email`, `full_name`, `phone`, `whatsapp`, `user_type`, etc.

3. Haz clic en la tabla **"products"**
4. Deberías ver columnas como:
   - `id`, `title`, `description`, `price`, `category`, `images`, `seller_id`, etc.

---

## ⚠️ Si Hay Errores

### Error: "relation already exists"
- **Causa**: Las tablas ya existen
- **Solución**: Puedes ignorar este error o eliminar las tablas y volver a crearlas

### Error: "permission denied"
- **Causa**: No tienes permisos suficientes
- **Solución**: Asegúrate de estar usando la cuenta de administrador del proyecto

### Error: "syntax error"
- **Causa**: El SQL está mal copiado
- **Solución**: 
  1. Copia TODO el contenido de `supabase_schema.sql` de nuevo
  2. Asegúrate de no haber cortado ninguna línea
  3. Pega completo en el editor

### Error: "column does not exist"
- **Causa**: Faltó ejecutar alguna parte del SQL
- **Solución**: Ejecuta TODO el contenido del archivo `supabase_schema.sql` de nuevo

---

## 📋 Checklist

Marca cada paso cuando lo completes:

- [ ] Abrí el dashboard de Supabase
- [ ] Seleccioné mi proyecto
- [ ] Abrí SQL Editor
- [ ] Creé una nueva consulta (New query)
- [ ] Copié TODO el contenido de `supabase_schema.sql`
- [ ] Pegué el SQL en el editor
- [ ] Ejecuté el SQL (botón Run)
- [ ] Verifiqué que se crearon las tablas `profiles` y `products`
- [ ] Revisé la estructura de las tablas

---

## 🎯 Próximo Paso

Una vez que las tablas estén creadas, el siguiente paso es:

**Crear el bucket de Storage para imágenes:**
1. Ve a **Storage** en el menú lateral
2. Crea un bucket llamado `product-images`
3. Márcalo como público

---

## 💡 Consejo

Si prefieres, puedes ejecutar el SQL por partes:
1. Primero ejecuta la parte que crea la tabla `profiles`
2. Luego ejecuta la parte que crea la tabla `products`
3. Finalmente ejecuta las políticas y triggers

Pero es más fácil ejecutar TODO de una vez. 😊

---

¡Una vez que completes estos pasos, tu base de datos estará lista! 🚀




