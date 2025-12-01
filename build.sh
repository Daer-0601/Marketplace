#!/bin/bash

# Script de build para Vercel
# Este script se ejecuta automáticamente en Vercel

echo "🚀 Iniciando build de Flutter Web..."

# Verificar que Flutter esté instalado
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter no está instalado. Instalando Flutter..."
    # Vercel tiene Flutter preinstalado, pero por si acaso
    export PATH="$PATH:/usr/local/flutter/bin"
fi

# Habilitar Flutter Web
flutter config --enable-web

# Obtener dependencias
echo "📦 Obteniendo dependencias..."
flutter pub get

# Limpiar builds anteriores
echo "🧹 Limpiando builds anteriores..."
flutter clean

# Build para web
echo "🔨 Construyendo aplicación web..."
flutter build web --release --web-renderer html

echo "✅ Build completado! Los archivos están en build/web"

