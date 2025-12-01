-- Script SQL para insertar datos de ejemplo
-- IMPORTANTE: Este script asume que ya tienes usuarios creados en auth.users
-- Los IDs de usuario deben ser reemplazados con los IDs reales de tus usuarios

-- ============================================
-- PASO 1: Crear usuarios en Supabase Auth primero
-- ============================================
-- Ve a Authentication > Users y crea estos usuarios:
-- 1. maria.artesana@example.com
-- 2. juan.joyero@example.com
-- 3. ana.textil@example.com
-- 4. carlos.comprador@example.com
-- 5. laura.comprador@example.com
-- 6. admin@marketplace.com

-- ============================================
-- PASO 2: Obtener los IDs reales de los usuarios
-- ============================================
-- Ejecuta esto para ver los IDs de tus usuarios:
-- SELECT id, email FROM auth.users;

-- ============================================
-- PASO 3: Reemplazar los IDs en este script
-- ============================================
-- Reemplaza 'REEMPLAZAR_CON_ID_REAL' con los IDs reales obtenidos en el paso 2

-- ============================================
-- Insertar Perfiles
-- ============================================
-- NOTA: Los perfiles se crean automáticamente cuando un usuario se registra
-- Si necesitas actualizar perfiles existentes, usa UPDATE en lugar de INSERT

-- Ejemplo de UPDATE para actualizar un perfil:
/*
UPDATE profiles 
SET 
  full_name = 'María González',
  phone = '+521234567890',
  whatsapp = '+521234567890',
  user_type = 'vendedor'
WHERE email = 'maria.artesana@example.com';
*/

-- ============================================
-- Insertar Productos de Ejemplo
-- ============================================
-- IMPORTANTE: Reemplaza 'REEMPLAZAR_CON_ID_REAL' con el ID real del vendedor

-- Producto 1: Macramé Decorativo (María)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Macramé Decorativo',
  'Macramé artesanal hecho a mano con hilo de algodón. Perfecto para decorar tu hogar. Medidas: 50cm x 80cm.',
  450.00,
  'Artesanías',
  ARRAY['https://images.unsplash.com/photo-1581833971358-2c8b550f87b3?w=400'],
  (SELECT id FROM profiles WHERE email = 'maria.artesana@example.com' LIMIT 1),
  true
);

-- Producto 2: Collar de Plata 925 (Juan)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Collar de Plata 925',
  'Collar artesanal de plata 925 con diseño único. Incluye cadena de 45cm.',
  850.00,
  'Joyería',
  ARRAY['https://images.unsplash.com/photo-1515562141207-7a88fb7ce338?w=400'],
  (SELECT id FROM profiles WHERE email = 'juan.joyero@example.com' LIMIT 1),
  true
);

-- Producto 3: Chal Artesanal (Ana)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Chal Artesanal',
  'Chal tejido a mano con lana 100% natural. Colores disponibles: beige, gris y marrón. Medidas: 180cm x 60cm.',
  320.00,
  'Textiles',
  ARRAY['https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=400'],
  (SELECT id FROM profiles WHERE email = 'ana.textil@example.com' LIMIT 1),
  true
);

-- Producto 4: Jarrón de Cerámica (María)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Jarrón de Cerámica',
  'Jarrón de cerámica artesanal con diseño único. Perfecto para flores o decoración. Altura: 25cm.',
  280.00,
  'Cerámica',
  ARRAY['https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400'],
  (SELECT id FROM profiles WHERE email = 'maria.artesana@example.com' LIMIT 1),
  true
);

-- Producto 5: Anillos de Acero Inoxidable (Juan)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Anillos de Acero Inoxidable',
  'Set de 3 anillos de acero inoxidable con diseños geométricos. Tallas ajustables.',
  150.00,
  'Joyería',
  ARRAY['https://images.unsplash.com/photo-1603561591411-07134e71a2a9?w=400'],
  (SELECT id FROM profiles WHERE email = 'juan.joyero@example.com' LIMIT 1),
  true
);

-- Producto 6: Bolsa de Tela Ecológica (Ana)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Bolsa de Tela Ecológica',
  'Bolsa de tela ecológica con diseño estampado. Perfecta para compras. Medidas: 40cm x 40cm.',
  120.00,
  'Textiles',
  ARRAY['https://images.unsplash.com/photo-1590736969955-71cc94901144?w=400'],
  (SELECT id FROM profiles WHERE email = 'ana.textil@example.com' LIMIT 1),
  true
);

-- Producto 7: Plato Decorativo (María)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Plato Decorativo',
  'Plato decorativo de cerámica con diseño tradicional. Diámetro: 30cm.',
  180.00,
  'Cerámica',
  ARRAY['https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?w=400'],
  (SELECT id FROM profiles WHERE email = 'maria.artesana@example.com' LIMIT 1),
  true
);

-- Producto 8: Pulsera de Cuentas (Juan)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Pulsera de Cuentas',
  'Pulsera artesanal de cuentas de madera y piedras naturales. Talla única ajustable.',
  95.00,
  'Joyería',
  ARRAY['https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400'],
  (SELECT id FROM profiles WHERE email = 'juan.joyero@example.com' LIMIT 1),
  true
);

-- Producto 9: Almohada Decorativa (Ana)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Almohada Decorativa',
  'Almohada decorativa con bordado artesanal. Relleno de plumas. Medidas: 50cm x 50cm.',
  250.00,
  'Textiles',
  ARRAY['https://images.unsplash.com/photo-1584100936595-3c8b8c0c0e5b?w=400'],
  (SELECT id FROM profiles WHERE email = 'ana.textil@example.com' LIMIT 1),
  true
);

-- Producto 10: Porta Velas (María)
INSERT INTO products (title, description, price, category, images, seller_id, is_active)
VALUES (
  'Porta Velas',
  'Porta velas de cerámica con diseño minimalista. Incluye 3 velas. Altura: 15cm.',
  200.00,
  'Cerámica',
  ARRAY['https://images.unsplash.com/photo-1606800053560-0c0c0c0c0c0?w=400'],
  (SELECT id FROM profiles WHERE email = 'maria.artesana@example.com' LIMIT 1),
  true
);

-- ============================================
-- Verificar que los datos se insertaron
-- ============================================
-- Ejecuta esto para ver los productos insertados:
-- SELECT id, title, price, category, seller_id FROM products ORDER BY created_at DESC;

-- ============================================
-- NOTAS IMPORTANTES
-- ============================================
-- 1. Los triggers automáticamente actualizarán seller_name y seller_whatsapp
-- 2. Las imágenes usan URLs de Unsplash (puedes cambiarlas por tus propias imágenes)
-- 3. Asegúrate de que los usuarios existan antes de ejecutar este script
-- 4. Si un usuario no existe, el INSERT fallará silenciosamente



