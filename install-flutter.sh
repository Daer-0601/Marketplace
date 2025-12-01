#!/bin/bash
set -e

echo "🚀 Instalando Flutter para Vercel..."

# Descargar Flutter
FLUTTER_VERSION="3.24.3"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "📥 Descargando Flutter ${FLUTTER_VERSION}..."
if ! curl -L "$FLUTTER_URL" | tar xJ; then
  echo "❌ Error al descargar Flutter"
  exit 1
fi

# Agregar Flutter al PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Verificar instalación
echo "✅ Verificando instalación de Flutter..."
if ! flutter --version; then
  echo "❌ Error: Flutter no se instaló correctamente"
  exit 1
fi

# Habilitar Flutter Web
echo "🌐 Habilitando Flutter Web..."
flutter config --enable-web --no-analytics || true

# Instalar dependencias
echo "📦 Instalando dependencias..."
if ! flutter pub get; then
  echo "❌ Error al instalar dependencias"
  exit 1
fi

# Build con variables de entorno
echo "🔨 Construyendo aplicación..."
BUILD_ARGS="--release --web-renderer html"

if [ -n "$SUPABASE_URL" ]; then
  BUILD_ARGS="$BUILD_ARGS --dart-define=SUPABASE_URL=$SUPABASE_URL"
fi

if [ -n "$SUPABASE_KEY" ]; then
  BUILD_ARGS="$BUILD_ARGS --dart-define=SUPABASE_KEY=$SUPABASE_KEY"
fi

if ! flutter build web $BUILD_ARGS; then
  echo "❌ Error al construir la aplicación"
  exit 1
fi

echo "✅ Build completado!"

