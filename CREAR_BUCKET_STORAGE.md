# 📦 Crear Bucket de Storage en Supabase

El error "Bucket not found" significa que necesitas crear el bucket `product-images` en Supabase Storage.

## 🚀 Pasos para Crear el Bucket

### 1. Ir a Storage en Supabase

1. Abre tu proyecto en Supabase Dashboard
2. En el menú lateral izquierdo, haz clic en **"Storage"**
3. Deberías ver una pantalla que dice "Create a new bucket" o una lista de buckets existentes

### 2. Crear el Bucket

1. Haz clic en el botón **"New bucket"** o **"Create bucket"**
2. Completa el formulario:
   - **Name**: `product-images` (debe ser exactamente este nombre)
   - **Public bucket**: ✅ **Marca esta casilla** (importante para que las imágenes sean accesibles públicamente)
   - **File size limit**: Opcional (puedes dejarlo en 50MB o el valor por defecto)
   - **Allowed MIME types**: Opcional (puedes dejarlo vacío o agregar `image/jpeg,image/png,image/webp`)
3. Haz clic en **"Create bucket"** o **"Save"**

### 3. Configurar Políticas RLS (Row Level Security)

Después de crear el bucket, necesitas configurar las políticas para permitir subir y leer imágenes:

#### Opción A: Usar SQL Editor (Recomendado)

1. Ve a **SQL Editor** en Supabase
2. Ejecuta este SQL:

```sql
-- Política para permitir a usuarios autenticados subir imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir subir imágenes a usuarios autenticados',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text) AND (auth.role() = ''authenticated''::text)'
);

-- Política para permitir lectura pública de imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir lectura pública de imágenes',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text)'
);
```

#### Opción B: Usar la Interfaz de Storage

1. Ve a **Storage > Policies**
2. Selecciona el bucket `product-images`
3. Haz clic en **"New Policy"**
4. Crea dos políticas:

   **Política 1 - Subir imágenes:**
   - **Policy name**: `Permitir subir imágenes`
   - **Allowed operation**: `INSERT`
   - **Policy definition**: 
     ```sql
     bucket_id = 'product-images'
     ```
   - **Policy check**:
     ```sql
     bucket_id = 'product-images' AND auth.role() = 'authenticated'
     ```

   **Política 2 - Leer imágenes:**
   - **Policy name**: `Permitir lectura pública`
   - **Allowed operation**: `SELECT`
   - **Policy definition**: 
     ```sql
     bucket_id = 'product-images'
     ```

### 4. Verificar que el Bucket Existe

1. Ve a **Storage** en Supabase
2. Deberías ver el bucket `product-images` en la lista
3. Haz clic en él para ver su contenido (debería estar vacío inicialmente)

## ✅ Verificación

Después de crear el bucket y las políticas:

1. Intenta subir una imagen desde tu app
2. Debería funcionar sin el error "Bucket not found"
3. Las imágenes se guardarán en: `products/{productId}/{timestamp}.jpg`

## 🔍 Solución de Problemas

### Si el bucket ya existe pero sigue dando error:

1. Verifica que el nombre sea exactamente `product-images` (sin espacios, minúsculas)
2. Verifica que el bucket esté marcado como **público**
3. Verifica las políticas RLS

### Si no puedes crear el bucket:

1. Verifica que tengas permisos de administrador en el proyecto
2. Intenta crear el bucket desde SQL Editor:

```sql
INSERT INTO storage.buckets (id, name, public)
VALUES ('product-images', 'product-images', true);
```

### Si las imágenes no se muestran:

1. Verifica que el bucket sea público
2. Verifica las políticas de lectura (SELECT)
3. Verifica que las URLs generadas sean correctas

---

¡Con estos pasos deberías poder subir imágenes correctamente! 🎉


