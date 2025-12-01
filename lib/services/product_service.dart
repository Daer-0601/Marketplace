import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product_model.dart';
import '../config/supabase_config.dart';

class ProductService {
  final _supabase = SupabaseConfig.client;

  // Crear producto
  Future<ProductModel> createProduct({
    required String title,
    required String description,
    required double price,
    required String category,
    required List<String> imageUrls,
    required String sellerId,
  }) async {
    try {
      // Obtener información del vendedor
      final sellerData = await _supabase
          .from('profiles')
          .select('full_name, whatsapp')
          .eq('id', sellerId)
          .single();

      final productData = {
        'title': title,
        'description': description,
        'price': price,
        'category': category,
        'images': imageUrls,
        'seller_id': sellerId,
        'seller_name': sellerData['full_name'],
        'seller_whatsapp': sellerData['whatsapp'],
        'is_active': true,
      };

      final response = await _supabase
          .from('products')
          .insert(productData)
          .select()
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error al crear producto: ${e.toString()}');
    }
  }

  // Obtener todos los productos
  Future<List<ProductModel>> getAllProducts({
    String? category,
    String? searchQuery,
  }) async {
    try {
      // Construir la consulta base
      var query = _supabase
          .from('products')
          .select()
          .eq('is_active', true);

      // Aplicar filtro de categoría si existe
      if (category != null && category.isNotEmpty) {
        query = query.eq('category', category);
      }

      // Aplicar búsqueda si existe
      if (searchQuery != null && searchQuery.isNotEmpty) {
        // Buscar en title usando ilike (case-insensitive)
        // Si necesitas buscar en múltiples campos, puedes hacer múltiples consultas o usar textSearch
        query = query.ilike('title', '%$searchQuery%');
      }

      // Aplicar ordenamiento y ejecutar
      final response = await query.order('created_at', ascending: false);

      return (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener productos: ${e.toString()}');
    }
  }

  // Obtener producto por ID
  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await _supabase
          .from('products')
          .select()
          .eq('id', id)
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error al obtener producto: ${e.toString()}');
    }
  }

  // Obtener productos de un vendedor
  Future<List<ProductModel>> getProductsBySeller(String sellerId) async {
    try {
      final response = await _supabase
          .from('products')
          .select()
          .eq('seller_id', sellerId)
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener productos del vendedor: ${e.toString()}');
    }
  }

  // Actualizar producto
  Future<ProductModel> updateProduct({
    required String id,
    String? title,
    String? description,
    double? price,
    String? category,
    List<String>? images,
    bool? isActive,
  }) async {
    try {
      final updates = <String, dynamic>{};
      if (title != null) updates['title'] = title;
      if (description != null) updates['description'] = description;
      if (price != null) updates['price'] = price;
      if (category != null) updates['category'] = category;
      if (images != null) updates['images'] = images;
      if (isActive != null) updates['is_active'] = isActive;
      updates['updated_at'] = DateTime.now().toIso8601String();

      final response = await _supabase
          .from('products')
          .update(updates)
          .eq('id', id)
          .select()
          .single();

      return ProductModel.fromJson(response);
    } catch (e) {
      throw Exception('Error al actualizar producto: ${e.toString()}');
    }
  }

  // Eliminar producto (soft delete)
  Future<void> deleteProduct(String id) async {
    try {
      await _supabase
          .from('products')
          .update({'is_active': false})
          .eq('id', id);
    } catch (e) {
      throw Exception('Error al eliminar producto: ${e.toString()}');
    }
  }

  // Obtener categorías disponibles
  Future<List<String>> getCategories() async {
    try {
      final response = await _supabase
          .from('products')
          .select('category')
          .eq('is_active', true);

      final categories = <String>{};
      for (var item in response) {
        if (item['category'] != null) {
          categories.add(item['category'] as String);
        }
      }

      return categories.toList()..sort();
    } catch (e) {
      return [];
    }
  }

  // Subir imagen a Supabase Storage
  Future<String> uploadImage(String imagePath, String productId) async {
    try {
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = 'products/$productId/$fileName';
      
      if (kIsWeb) {
        // En web, el imagePath es una URL blob, necesitamos leer los bytes
        // Por ahora, en web no podemos subir directamente desde blob URL
        // Necesitamos que el usuario suba la imagen de otra manera
        throw Exception('La subida de imágenes desde web requiere configuración adicional. Por favor, usa la app móvil para subir imágenes.');
      } else {
        // Es móvil - usar File
        final file = File(imagePath);
        await _supabase.storage.from('product-images').upload(
              filePath,
              file,
            );
      }

      final imageUrl = _supabase.storage
          .from('product-images')
          .getPublicUrl(filePath);

      return imageUrl;
    } catch (e) {
      throw Exception('Error al subir imagen: ${e.toString()}');
    }
  }
}

