import 'dart:convert';

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final List<String> images;
  final String sellerId;
  final String? sellerName;
  final String? sellerWhatsapp;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;

  // Helper para parsear imágenes que pueden venir como List o String (JSON)
  static List<String> _parseImages(dynamic imagesData) {
    if (imagesData == null) return [];
    
    // Si ya es una List, convertirla directamente
    if (imagesData is List) {
      return imagesData.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
    }
    
    // Si es un String, intentar parsearlo como JSON
    if (imagesData is String) {
      try {
        // Si el string parece ser un JSON array, parsearlo
        if (imagesData.trim().startsWith('[')) {
          final parsed = jsonDecode(imagesData) as List;
          return parsed.map((e) => e?.toString() ?? '').where((e) => e.isNotEmpty).toList();
        }
        // Si es un string simple, devolverlo como lista con un elemento
        return imagesData.isNotEmpty ? [imagesData] : [];
      } catch (e) {
        // Si falla el parseo, devolver el string como lista con un elemento
        return imagesData.isNotEmpty ? [imagesData] : [];
      }
    }
    
    return [];
  }

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.images,
    required this.sellerId,
    this.sellerName,
    this.sellerWhatsapp,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      category: json['category']?.toString() ?? '',
      images: _parseImages(json['images']),
      sellerId: json['seller_id']?.toString() ?? '',
      sellerName: json['seller_name']?.toString(),
      sellerWhatsapp: json['seller_whatsapp']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'].toString())
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'].toString())
          : null,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'category': category,
      'images': images,
      'seller_id': sellerId,
      'seller_name': sellerName,
      'seller_whatsapp': sellerWhatsapp,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_active': isActive,
    };
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? category,
    List<String>? images,
    String? sellerId,
    String? sellerName,
    String? sellerWhatsapp,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      images: images ?? this.images,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerWhatsapp: sellerWhatsapp ?? this.sellerWhatsapp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

