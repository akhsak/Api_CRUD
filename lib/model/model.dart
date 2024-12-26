class UserModel {
  final int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  String? gender;
  String? description;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
    required this.gender,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'], // Convert int to String
      name: json['name'],
      email: json['email'],
      phone: json['phone'].toString(), // Convert int to String
      address: json['address'],
      gender: json['gender'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
