-- ============================================
-- SOLUCIÓN COMPLETA: Trigger para crear perfil automáticamente
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Eliminar políticas de inserción existentes
DROP POLICY IF EXISTS "Los usuarios pueden insertar su propio perfil" ON profiles;

-- 2. Crear función que crea el perfil automáticamente
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, user_type)
  VALUES (
    NEW.id::uuid,
    NEW.email::text,
    COALESCE(NEW.raw_user_meta_data->>'full_name', '')::text,
    COALESCE(NEW.raw_user_meta_data->>'user_type', 'comprador')::text
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 3. Crear trigger que se ejecuta cuando se crea un usuario
DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- 4. Política para permitir que los usuarios actualicen su perfil
DROP POLICY IF EXISTS "Los usuarios pueden actualizar su propio perfil" ON profiles;
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
  ON profiles FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- 5. Política para permitir que los usuarios vean todos los perfiles
DROP POLICY IF EXISTS "Los usuarios pueden ver todos los perfiles" ON profiles;
CREATE POLICY "Los usuarios pueden ver todos los perfiles"
  ON profiles FOR SELECT
  USING (true);

-- 6. Verificar que RLS esté habilitado
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- ============================================
-- NOTA: Con este trigger, NO necesitas insertar manualmente en profiles
-- El perfil se crea automáticamente cuando se registra un usuario
-- ============================================

