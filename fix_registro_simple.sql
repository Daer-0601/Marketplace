-- ============================================
-- SOLUCIÓN SIMPLE: Política RLS más permisiva
-- ============================================
-- Si el trigger no funciona, usa esta solución más simple

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

-- 3. Verificar que RLS esté habilitado
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- 4. Verificar políticas existentes
-- SELECT * FROM pg_policies WHERE tablename = 'profiles';


