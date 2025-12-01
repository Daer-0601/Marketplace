@echo off
REM ============================================
REM Script para ejecutar la app con variables de entorno
REM ============================================
REM 
REM INSTRUCCIONES:
REM 1. Reemplaza TU_CLAVE_ANON_AQUI con tu clave anon de Supabase
REM 2. Guarda el archivo
REM 3. Ejecuta: run.bat
REM
REM Para obtener tu clave anon:
REM - Ve a https://supabase.com/dashboard
REM - Settings > API > Project API keys
REM - Copia la clave "anon" o "public"
REM ============================================

flutter run --dart-define=SUPABASE_KEY=sb_publishable_dZ0Bjel-A_5rGmeNwJNc-A_8Qqx7loQ

pause

