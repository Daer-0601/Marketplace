-- ============================================
-- Script para Crear Bucket de Storage
-- ============================================
-- Ejecuta esto en SQL Editor de Supabase

-- 1. Crear el bucket 'product-images'
INSERT INTO storage.buckets (id, name, public)
VALUES ('product-images', 'product-images', true)
ON CONFLICT (id) DO NOTHING;

-- 2. Verificar que el bucket se creó
SELECT id, name, public, created_at 
FROM storage.buckets 
WHERE id = 'product-images';

-- ============================================
-- 3. Crear políticas RLS para el bucket
-- ============================================

-- Política para permitir a usuarios autenticados subir imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir subir imágenes a usuarios autenticados',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text) AND (auth.role() = ''authenticated''::text)'
)
ON CONFLICT DO NOTHING;

-- Política para permitir lectura pública de imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir lectura pública de imágenes',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text)'
)
ON CONFLICT DO NOTHING;

-- Política para permitir a usuarios autenticados actualizar sus propias imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir actualizar imágenes propias',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text) AND (auth.role() = ''authenticated''::text)'
)
ON CONFLICT DO NOTHING;

-- Política para permitir a usuarios autenticados eliminar sus propias imágenes
INSERT INTO storage.policies (name, bucket_id, definition, check_expression)
VALUES (
  'Permitir eliminar imágenes propias',
  'product-images',
  '(bucket_id = ''product-images''::text)',
  '(bucket_id = ''product-images''::text) AND (auth.role() = ''authenticated''::text)'
)
ON CONFLICT DO NOTHING;

-- ============================================
-- 4. Verificar las políticas creadas
-- ============================================
SELECT 
  name,
  bucket_id,
  definition,
  check_expression
FROM storage.policies
WHERE bucket_id = 'product-images';

-- ============================================
-- ✅ Listo! El bucket está creado y configurado
-- ============================================

