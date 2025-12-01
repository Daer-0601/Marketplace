-- ============================================
-- SOLUCIÓN FINAL: Política RLS Corregida
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Eliminar políticas de inserción existentes
DROP POLICY IF EXISTS "Los usuarios pueden insertar su propio perfil" ON profiles;

-- 2. Crear política que permite inserción durante registro
-- Esta política permite que un usuario autenticado inserte su propio perfil
CREATE POLICY "Los usuarios pueden insertar su propio perfil"
  ON profiles FOR INSERT
  WITH CHECK (
    auth.uid() IS NOT NULL AND
    auth.uid()::text = id::text
  );

-- 3. Verificar que las otras políticas estén correctas
DROP POLICY IF EXISTS "Los usuarios pueden actualizar su propio perfil" ON profiles;
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
  ON profiles FOR UPDATE
  USING (auth.uid()::text = id::text)
  WITH CHECK (auth.uid()::text = id::text);

DROP POLICY IF EXISTS "Los usuarios pueden ver todos los perfiles" ON profiles;
CREATE POLICY "Los usuarios pueden ver todos los perfiles"
  ON profiles FOR SELECT
  USING (true);

-- 4. Verificar que RLS esté habilitado
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- ============================================
-- VERIFICACIÓN
-- ============================================
-- Ejecuta esto para ver todas las políticas:
-- SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual, with_check
-- FROM pg_policies 
-- WHERE tablename = 'profiles';

