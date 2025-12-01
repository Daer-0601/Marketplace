import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../config/supabase_config.dart';

class AuthService {
  final _supabase = SupabaseConfig.client;

  User? get currentUser => _supabase.auth.currentUser;

  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
    String? whatsapp,
    required String userType,
  }) async {
    try {
      // Registrar usuario en Supabase Auth
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'user_type': userType,
        },
      );

      if (response.user == null) {
        throw Exception('Error al crear el usuario');
      }

      // Verificar si el perfil ya existe
      try {
        final existingProfile = await _supabase
            .from('profiles')
            .select()
            .eq('id', response.user!.id)
            .maybeSingle();

        if (existingProfile != null) {
          // Si ya existe, actualizarlo con la información nueva
          await _supabase
              .from('profiles')
              .update({
                'email': email,
                'full_name': fullName,
                'phone': phone,
                'whatsapp': whatsapp,
                'user_type': userType,
              })
              .eq('id', response.user!.id);

          // Obtener el perfil actualizado
          final updatedProfile = await _supabase
              .from('profiles')
              .select()
              .eq('id', response.user!.id)
              .single();

          return UserModel.fromJson(updatedProfile);
        }
      } catch (e) {
        // Si no existe, continuar para crearlo
      }

      // Crear perfil en la tabla profiles (solo si no existe)
      await _supabase.from('profiles').insert({
        'id': response.user!.id,
        'email': email,
        'full_name': fullName,
        'phone': phone,
        'whatsapp': whatsapp,
        'user_type': userType,
      });

      // Obtener el perfil creado
      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', response.user!.id)
          .single();

      return UserModel.fromJson(profileData);
    } catch (e) {
      throw Exception('Error al registrar: ${e.toString()}');
    }
  }

  Future<UserModel?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );

      if (response.user == null) {
        throw Exception('Credenciales inválidas');
      }

      // Debug: Verificar estado del usuario
      debugPrint('Usuario autenticado: ${response.user!.email}');
      debugPrint('Email confirmado: ${response.user!.emailConfirmedAt}');

      // Intentar obtener perfil del usuario
      try {
        final profileData = await _supabase
            .from('profiles')
            .select()
            .eq('id', response.user!.id)
            .single();

        return UserModel.fromJson(profileData);
      } catch (e) {
        // Si el perfil no existe, crearlo con datos básicos
        final userMetadata = response.user!.userMetadata;
        await _supabase.from('profiles').insert({
          'id': response.user!.id,
          'email': email,
          'full_name': userMetadata?['full_name'] ?? email.split('@')[0],
          'user_type': userMetadata?['user_type'] ?? 'comprador',
        });

        // Obtener el perfil recién creado
        final profileData = await _supabase
            .from('profiles')
            .select()
            .eq('id', response.user!.id)
            .single();

        return UserModel.fromJson(profileData);
      }
    } on AuthException catch (e) {
      // Manejar errores específicos de autenticación
      String errorMessage = 'Error al iniciar sesión';
      
      if (e.message.contains('Invalid login credentials') || 
          e.message.contains('Invalid credentials') ||
          e.message.contains('400') ||
          e.message.contains('Bad Request')) {
        errorMessage = 'Email o contraseña incorrectos. Verifica tus credenciales.';
      } else if (e.message.contains('Email not confirmed') ||
                 e.message.contains('email_not_confirmed')) {
        errorMessage = 'Por favor confirma tu email antes de iniciar sesión. Revisa tu bandeja de entrada.';
      } else if (e.message.contains('User not found') ||
                 e.message.contains('user_not_found')) {
        errorMessage = 'Usuario no encontrado. Por favor regístrate primero.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      
      throw Exception(errorMessage);
    } on PostgrestException catch (e) {
      // Manejar errores de Postgrest (incluye errores 400)
      String errorMessage = 'Error al iniciar sesión';
      
      if (e.code == '400' || e.message.contains('400') || e.message.contains('Bad Request')) {
        errorMessage = 'Email o contraseña incorrectos. Verifica tus credenciales.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }
      
      throw Exception(errorMessage);
    } catch (e) {
      // Manejar otros errores
      final errorString = e.toString();
      if (errorString.contains('400') || 
          errorString.contains('Bad Request') ||
          errorString.contains('Invalid login')) {
        throw Exception('Email o contraseña incorrectos. Verifica tus credenciales.');
      }
      throw Exception('Error al iniciar sesión: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: ${e.toString()}');
    }
  }

  Future<UserModel?> getCurrentUserProfile() async {
    try {
      final user = currentUser;
      if (user == null) return null;

      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return UserModel.fromJson(profileData);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProfile({
    String? fullName,
    String? phone,
    String? whatsapp,
    String? profileImage,
  }) async {
    try {
      final user = currentUser;
      if (user == null) throw Exception('Usuario no autenticado');

      final updates = <String, dynamic>{};
      if (fullName != null) updates['full_name'] = fullName;
      if (phone != null) updates['phone'] = phone;
      if (whatsapp != null) updates['whatsapp'] = whatsapp;
      if (profileImage != null) updates['profile_image'] = profileImage;

      await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', user.id);
    } catch (e) {
      throw Exception('Error al actualizar perfil: ${e.toString()}');
    }
  }
}

