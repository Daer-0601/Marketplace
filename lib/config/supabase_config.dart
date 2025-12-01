import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  // ═══════════════════════════════════════════════════════════════
  // CONFIGURACIÓN DE SUPABASE
  // ═══════════════════════════════════════════════════════════════
  // 
  // OPCIÓN 1: Usar variables de entorno (RECOMENDADO)
  // Ejecuta la app con: flutter run --dart-define=SUPABASE_KEY=tu_clave_aqui
  //
  // OPCIÓN 2: Configurar directamente (para desarrollo)
  // Reemplaza el valor por defecto de supabaseAnonKey abajo
  //
  // Para obtener tu clave anon:
  // 1. Ve a https://supabase.com/dashboard
  // 2. Settings > API > Project API keys
  // 3. Copia la clave "anon" o "public"
  // ═══════════════════════════════════════════════════════════════
  
  // URL de tu proyecto Supabase
  // Se puede configurar desde variable de entorno para producción (Vercel)
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://riifvjrfcynrtbkfeoyq.supabase.co',
  );
  
  // Clave anon - Se obtiene de variable de entorno o valor por defecto
  // Si usas --dart-define, esta variable se reemplazará automáticamente
  // Para Vercel: Configura SUPABASE_KEY en las variables de entorno
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_KEY',
    defaultValue: 'sb_publishable_dZ0Bjel-A_5rGmeNwJNc-A_8Qqx7loQ', // Clave configurada
  );

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}

