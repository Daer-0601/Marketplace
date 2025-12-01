-- ============================================
-- SOLUCIÓN: Corregir Políticas RLS para Registro
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Eliminar la política de inserción existente (si existe)
DROP POLICY IF EXISTS "Los usuarios pueden insertar su propio perfil" ON profiles;

-- 2. Crear una nueva política que permita la inserción durante el registro
CREATE POLICY "Los usuarios pueden insertar su propio perfil"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- 3. Verificar que RLS esté habilitado
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- ============================================
-- ALTERNATIVA: Si el problema persiste, usa esta política más permisiva
-- ============================================
-- Descomenta estas líneas si la anterior no funciona:

-- DROP POLICY IF EXISTS "Los usuarios pueden insertar su propio perfil" ON profiles;
-- 
-- CREATE POLICY "Los usuarios pueden insertar su propio perfil"
--   ON profiles FOR INSERT
--   WITH CHECK (
--     auth.uid() = id OR
--     auth.uid() IS NOT NULL
--   );

-- ============================================
-- VERIFICACIÓN: Ver las políticas actuales
-- ============================================
-- Ejecuta esto para ver todas las políticas:
-- SELECT * FROM pg_policies WHERE tablename = 'profiles';


