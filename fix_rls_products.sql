-- ============================================
-- Corregir políticas RLS para la tabla products
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Eliminar políticas existentes (si existen)
DROP POLICY IF EXISTS "Todos pueden ver productos activos" ON products;
DROP POLICY IF EXISTS "Los vendedores pueden ver sus propios productos" ON products;
DROP POLICY IF EXISTS "Solo vendedores pueden crear productos" ON products;
DROP POLICY IF EXISTS "Los vendedores pueden actualizar sus propios productos" ON products;
DROP POLICY IF EXISTS "Los vendedores pueden eliminar sus propios productos" ON products;

-- 2. Crear políticas corregidas

-- Política 1: Todos pueden ver productos activos
CREATE POLICY "Todos pueden ver productos activos"
  ON products FOR SELECT
  USING (is_active = true);

-- Política 2: Los usuarios pueden ver sus propios productos (incluso inactivos)
CREATE POLICY "Los usuarios pueden ver sus propios productos"
  ON products FOR SELECT
  USING (seller_id::text = auth.uid()::text);

-- Política 3: Permitir a usuarios autenticados crear productos
-- Verificar que el seller_id coincida con el usuario autenticado
CREATE POLICY "Usuarios autenticados pueden crear productos"
  ON products FOR INSERT
  WITH CHECK (
    auth.uid() IS NOT NULL AND
    seller_id::text = auth.uid()::text
  );

-- Política 4: Los usuarios pueden actualizar solo sus propios productos
CREATE POLICY "Los usuarios pueden actualizar sus propios productos"
  ON products FOR UPDATE
  USING (seller_id::text = auth.uid()::text)
  WITH CHECK (seller_id::text = auth.uid()::text);

-- Política 5: Los usuarios pueden eliminar (soft delete) solo sus propios productos
CREATE POLICY "Los usuarios pueden eliminar sus propios productos"
  ON products FOR UPDATE
  USING (seller_id::text = auth.uid()::text)
  WITH CHECK (seller_id::text = auth.uid()::text);

-- ============================================
-- 3. Verificar las políticas creadas
-- ============================================
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual,
  with_check
FROM pg_policies
WHERE tablename = 'products'
ORDER BY policyname;

-- ============================================
-- ✅ Listo! Las políticas RLS están corregidas
-- ============================================
-- Nota: Ahora cualquier usuario autenticado puede crear productos
-- siempre que el seller_id coincida con su ID de usuario

