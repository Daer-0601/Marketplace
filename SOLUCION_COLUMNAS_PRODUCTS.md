# 🔧 Solución: Error "Could not find the 'seller_name' column"

El error indica que la tabla `products` no tiene las columnas `seller_name` y `seller_whatsapp` que el código necesita.

## 🚀 Solución Rápida

### Paso 1: Agregar las Columnas Faltantes

1. Ve a **SQL Editor** en Supabase Dashboard
2. Abre el archivo `agregar_columnas_products.sql`
3. Ejecuta todo el SQL
4. Esto agregará las columnas `seller_name` y `seller_whatsapp` a la tabla `products`

### Paso 2: Verificar

Ejecuta este SQL para verificar que las columnas se agregaron:

```sql
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'products'
AND column_name IN ('seller_name', 'seller_whatsapp');
```

Deberías ver ambas columnas listadas.

## 📝 ¿Qué hace el script?

1. **Agrega las columnas faltantes:**
   - `seller_name TEXT` - Nombre del vendedor
   - `seller_whatsapp TEXT` - WhatsApp del vendedor

2. **Crea un trigger automático:**
   - Cuando se crea o actualiza un producto, el trigger actualiza automáticamente `seller_name` y `seller_whatsapp` basándose en el `seller_id`
   - Esto asegura que la información del vendedor esté siempre actualizada

## ✅ Después de ejecutar el script

1. Intenta crear un producto de nuevo
2. Debería funcionar sin el error "Could not find the 'seller_name' column"
3. Las columnas se llenarán automáticamente con la información del vendedor

## 🔍 Columnas que se agregan

- **seller_name**: Nombre completo del vendedor (desde `profiles.full_name`)
- **seller_whatsapp**: Número de WhatsApp del vendedor (desde `profiles.whatsapp`)

Estas columnas se actualizan automáticamente cuando se crea o modifica un producto, usando la información del perfil del vendedor.

---

¡Con este cambio deberías poder crear productos correctamente! 🎉

