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
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List)
          : [],
      sellerId: json['seller_id'] as String,
      sellerName: json['seller_name'] as String?,
      sellerWhatsapp: json['seller_whatsapp'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
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

