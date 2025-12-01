class UserModel {
  final String id;
  final String email;
  final String? fullName;
  final String? phone;
  final String? whatsapp;
  final String? profileImage;
  final String userType; // 'vendedor' o 'comprador'
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.email,
    this.fullName,
    this.phone,
    this.whatsapp,
    this.profileImage,
    required this.userType,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Función helper para convertir a String
    String? _toString(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      if (value is int) return value.toString();
      if (value is double) return value.toString();
      return value.toString();
    }

    return UserModel(
      id: _toString(json['id']) ?? '',
      email: _toString(json['email']) ?? '',
      fullName: _toString(json['full_name']),
      phone: _toString(json['phone']),
      whatsapp: _toString(json['whatsapp']),
      profileImage: _toString(json['profile_image']),
      userType: _toString(json['user_type']) ?? 'comprador',
      createdAt: json['created_at'] != null
          ? DateTime.parse(_toString(json['created_at']) ?? '')
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'phone': phone,
      'whatsapp': whatsapp,
      'profile_image': profileImage,
      'user_type': userType,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}

