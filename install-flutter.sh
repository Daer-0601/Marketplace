#!/bin/bash
set -e

echo "🚀 Instalando Flutter para Vercel..."

# Descargar Flutter
FLUTTER_VERSION="3.24.3"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

echo "📥 Descargando Flutter ${FLUTTER_VERSION}..."
curl -L "$FLUTTER_URL" | tar xJ

# Agregar Flutter al PATH
export PATH="$PATH:$(pwd)/flutter/bin"

# Verificar instalación
echo "✅ Verificando instalación de Flutter..."
flutter --version

# Habilitar Flutter Web
echo "🌐 Habilitando Flutter Web..."
flutter config --enable-web

# Aceptar licencias
echo "📝 Aceptando licencias de Flutter..."
yes | flutter doctor --android-licenses || true

echo "✅ Flutter instalado correctamente!"

