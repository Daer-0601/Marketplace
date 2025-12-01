-- ============================================
-- Renombrar tabla Products a products
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- Renombrar la tabla de "Products" a "products" (minúscula)
ALTER TABLE "Products" RENAME TO products;

-- Verificar que se renombró correctamente
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_name IN ('products', 'Products')
ORDER BY table_name;

-- ============================================
-- ✅ Listo! La tabla ahora se llama "products"
-- ============================================

