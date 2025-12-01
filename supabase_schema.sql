-- Esquema de base de datos para Marketplace Artesanal
-- Ejecuta estos comandos en el SQL Editor de Supabase

-- 1. Crear tabla de perfiles de usuario
CREATE TABLE IF NOT EXISTS profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  full_name TEXT,
  phone TEXT,
  whatsapp TEXT,
  profile_image TEXT,
  user_type TEXT NOT NULL DEFAULT 'comprador' CHECK (user_type IN ('vendedor', 'comprador')),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 2. Habilitar Row Level Security (RLS)
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- 3. Políticas de seguridad para profiles
-- Los usuarios pueden ver todos los perfiles
CREATE POLICY "Los usuarios pueden ver todos los perfiles"
  ON profiles FOR SELECT
  USING (true);

-- Los usuarios pueden actualizar solo su propio perfil
CREATE POLICY "Los usuarios pueden actualizar su propio perfil"
  ON profiles FOR UPDATE
  USING (auth.uid() = id);

-- Los usuarios pueden insertar solo su propio perfil
CREATE POLICY "Los usuarios pueden insertar su propio perfil"
  ON profiles FOR INSERT
  WITH CHECK (auth.uid() = id);

-- 4. Crear tabla de productos
CREATE TABLE IF NOT EXISTS products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL(10, 2) NOT NULL CHECK (price > 0),
  category TEXT NOT NULL,
  images TEXT[] DEFAULT '{}',
  seller_id UUID REFERENCES profiles(id) ON DELETE CASCADE NOT NULL,
  seller_name TEXT,
  seller_whatsapp TEXT,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- 5. Habilitar RLS para products
ALTER TABLE products ENABLE ROW LEVEL SECURITY;

-- 6. Políticas de seguridad para products
-- Todos pueden ver productos activos
CREATE POLICY "Todos pueden ver productos activos"
  ON products FOR SELECT
  USING (is_active = true);

-- Los vendedores pueden ver sus propios productos (incluso inactivos)
CREATE POLICY "Los vendedores pueden ver sus propios productos"
  ON products FOR SELECT
  USING (
    seller_id = auth.uid() OR
    (SELECT user_type FROM profiles WHERE id = auth.uid()) = 'vendedor'
  );

-- Solo vendedores pueden crear productos
CREATE POLICY "Solo vendedores pueden crear productos"
  ON products FOR INSERT
  WITH CHECK (
    seller_id = auth.uid() AND
    (SELECT user_type FROM profiles WHERE id = auth.uid()) = 'vendedor'
  );

-- Los vendedores pueden actualizar solo sus propios productos
CREATE POLICY "Los vendedores pueden actualizar sus propios productos"
  ON products FOR UPDATE
  USING (seller_id = auth.uid())
  WITH CHECK (seller_id = auth.uid());

-- Los vendedores pueden eliminar (soft delete) solo sus propios productos
CREATE POLICY "Los vendedores pueden eliminar sus propios productos"
  ON products FOR UPDATE
  USING (seller_id = auth.uid())
  WITH CHECK (seller_id = auth.uid());

-- 7. Crear función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 8. Crear triggers para updated_at
CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_products_updated_at
  BEFORE UPDATE ON products
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- 9. Crear función para actualizar seller_name y seller_whatsapp automáticamente
CREATE OR REPLACE FUNCTION update_product_seller_info()
RETURNS TRIGGER AS $$
BEGIN
  SELECT full_name, whatsapp INTO NEW.seller_name, NEW.seller_whatsapp
  FROM profiles
  WHERE id = NEW.seller_id;
  RETURN NEW;
END;
$$ language 'plpgsql';

-- 10. Crear trigger para actualizar información del vendedor
CREATE TRIGGER update_product_seller_info_trigger
  BEFORE INSERT OR UPDATE ON products
  FOR EACH ROW
  EXECUTE FUNCTION update_product_seller_info();

-- 11. Crear bucket de almacenamiento para imágenes (ejecutar en Storage de Supabase)
-- Ve a Storage en el dashboard de Supabase y crea un bucket llamado 'product-images'
-- Con las siguientes políticas:
-- - Public Access: true (o configurar políticas específicas)
-- - File size limit: 5MB (recomendado)
-- - Allowed MIME types: image/jpeg, image/png, image/webp

-- 12. Índices para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_products_seller_id ON products(seller_id);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_is_active ON products(is_active);
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_profiles_user_type ON profiles(user_type);

