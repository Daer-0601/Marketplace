#!/bin/bash
# ============================================
# Script para ejecutar la app con variables de entorno
# ============================================
# 
# INSTRUCCIONES:
# 1. Reemplaza TU_CLAVE_ANON_AQUI con tu clave anon de Supabase
# 2. Guarda el archivo
# 3. Ejecuta: chmod +x run.sh && ./run.sh
#
# Para obtener tu clave anon:
# - Ve a https://supabase.com/dashboard
# - Settings > API > Project API keys
# - Copia la clave "anon" o "public"
# ============================================

flutter run --dart-define=SUPABASE_KEY=TU_CLAVE_ANON_AQUI

