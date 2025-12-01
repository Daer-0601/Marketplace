-- ============================================
-- SOLUCIÓN SIMPLE: Política RLS con casts explícitos
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Eliminar todas las políticas existentes de profiles
DROP POLICY IF EXISTS "Los usuarios pueden insertar su propio perfil" ON profiles;
DROP POLICY IF EXISTS "Los usuarios pueden actualizar su propio perfil" ON profiles;
DROP POLICY IF EXISTS "Los usuarios pueden ver todos los perfiles" ON profiles;

-- 2. Crear política de inserción (con cast explícito)
CREATE POLICY "Los usuarios pueden insertar su propio perfil"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid()::text = id::text);

-- 3. Crear política de actualización (con cast explícito)
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
  ON profiles FOR UPDATE
  USING (auth.uid()::text = id::text)
  WITH CHECK (auth.uid()::text = id::text);

-- 4. Crear política de lectura (todos pueden ver)
CREATE POLICY "Los usuarios pueden ver todos los perfiles"
  ON profiles FOR SELECT
  USING (true);

-- 5. Asegurar que RLS esté habilitado
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- ============================================
-- VERIFICACIÓN
-- ============================================
-- Ejecuta esto para verificar las políticas:
-- SELECT policyname, cmd, qual, with_check 
-- FROM pg_policies 
-- WHERE tablename = 'profiles';


