-- ============================================
-- Agregar columnas faltantes a la tabla products
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- Verificar columnas actuales de la tabla products
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'products'
ORDER BY ordinal_position;

-- Agregar columna seller_name si no existe
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'products' 
    AND column_name = 'seller_name'
  ) THEN
    ALTER TABLE products ADD COLUMN seller_name TEXT;
  END IF;
END $$;

-- Agregar columna seller_whatsapp si no existe
DO $$ 
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.columns 
    WHERE table_schema = 'public' 
    AND table_name = 'products' 
    AND column_name = 'seller_whatsapp'
  ) THEN
    ALTER TABLE products ADD COLUMN seller_whatsapp TEXT;
  END IF;
END $$;

-- Verificar que las columnas se agregaron
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'public' 
AND table_name = 'products'
AND column_name IN ('seller_name', 'seller_whatsapp')
ORDER BY column_name;

-- ============================================
-- Opcional: Crear función y trigger para actualizar automáticamente
-- ============================================

-- Crear función para actualizar seller_name y seller_whatsapp automáticamente
CREATE OR REPLACE FUNCTION update_product_seller_info()
RETURNS TRIGGER AS $$
BEGIN
  SELECT full_name, whatsapp INTO NEW.seller_name, NEW.seller_whatsapp
  FROM profiles
  WHERE id = NEW.seller_id;
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Crear trigger para actualizar información del vendedor
DROP TRIGGER IF EXISTS update_product_seller_info_trigger ON products;
CREATE TRIGGER update_product_seller_info_trigger
  BEFORE INSERT OR UPDATE ON products
  FOR EACH ROW
  EXECUTE FUNCTION update_product_seller_info();

-- ============================================
-- ✅ Listo! Las columnas están agregadas
-- ============================================
-- Nota: El trigger actualizará automáticamente seller_name y seller_whatsapp
-- cuando se inserte o actualice un producto, basándose en el seller_id

