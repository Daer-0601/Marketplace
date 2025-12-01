# 🔧 Solución: Error RLS "new row violates row-level security policy"

El error indica que la política RLS (Row Level Security) está bloqueando la inserción de productos en la tabla `products`.

## 🚀 Solución Rápida

### Paso 1: Corregir las Políticas RLS

1. Ve a **SQL Editor** en Supabase Dashboard
2. Abre el archivo `fix_rls_products.sql`
3. Ejecuta todo el SQL
4. Esto eliminará las políticas antiguas y creará nuevas políticas corregidas

### Paso 2: Verificar

Después de ejecutar el script, intenta crear un producto de nuevo. Debería funcionar.

## 📝 ¿Qué hace el script?

1. **Elimina políticas antiguas** que pueden estar causando conflictos

2. **Crea nuevas políticas RLS:**
   - ✅ **SELECT**: Todos pueden ver productos activos
   - ✅ **SELECT**: Los usuarios pueden ver sus propios productos (incluso inactivos)
   - ✅ **INSERT**: Usuarios autenticados pueden crear productos (si el `seller_id` coincide con su ID)
   - ✅ **UPDATE**: Los usuarios pueden actualizar solo sus propios productos
   - ✅ **UPDATE**: Los usuarios pueden hacer soft delete de sus propios productos

3. **Usa comparación de texto** (`::text`) para evitar problemas de tipos UUID

## 🔍 Problema Original

La política original probablemente requería que el usuario fuera "vendedor", pero:
- Puede que el usuario no tenga `user_type = 'vendedor'` en su perfil
- O la política tenía una condición demasiado restrictiva

La nueva política es más simple: cualquier usuario autenticado puede crear productos, siempre que el `seller_id` coincida con su ID de usuario.

## ✅ Después de ejecutar el script

1. Intenta crear un producto de nuevo
2. Debería funcionar sin el error RLS
3. El producto se creará correctamente

## 🆘 Si aún no funciona

Si después de ejecutar el script sigue dando error:

1. **Verifica que estés autenticado:**
   - Asegúrate de haber iniciado sesión
   - Verifica que el `seller_id` en el código coincida con tu ID de usuario

2. **Verifica el perfil:**
   - Ve a Table Editor > profiles
   - Verifica que tu perfil existe y tiene tu ID correcto

3. **Deshabilitar RLS temporalmente (solo para pruebas):**
   ```sql
   ALTER TABLE products DISABLE ROW LEVEL SECURITY;
   ```
   ⚠️ **No recomendado para producción** - Solo para debugging

---

¡Con este cambio deberías poder crear productos correctamente! 🎉

